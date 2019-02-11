locals {
  gke_pool_create = "${var.gke_pool_create}"

  gke_service_account_roles = [
    "roles/logging.logWriter",       # Write logs
    "roles/monitoring.metricWriter", # Write metrics
  ]
}

resource "google_service_account" "vault_gke" {
  count = "${local.gke_pool_create ? 1 : 0}"

  account_id   = "${var.gke_service_account_id}"
  display_name = "Service Account for the GKE cluster ${var.gke_pool_name} pools"

  project = "${var.gke_project}"
}

resource "google_container_node_pool" "vault" {
  provider = "google-beta"
  count    = "${local.gke_pool_create ? 1 : 0}"

  name    = "${var.gke_pool_name}"
  region  = "${var.gke_pool_region}"
  zone    = "${var.gke_pool_zone}"
  cluster = "${var.gke_cluster}"
  project = "${var.gke_project}"

  initial_node_count = "${var.gke_node_count}"
  node_count         = "${var.gke_node_count}"

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  node_config {
    disk_size_gb = "${var.gke_node_size_gb}"
    disk_type    = "${var.gke_disk_type}"
    machine_type = "${var.gke_machine_type}"

    labels          = "${var.gke_labels}"
    metadata        = "${var.gke_metadata}"
    tags            = ["${var.gke_tags}"]
    taint           = ["${var.gke_taints}"]
    service_account = "${google_service_account.vault_gke.email}"

    # See https://cloud.google.com/kubernetes-engine/docs/how-to/protecting-cluster-metadata#concealment
    workload_metadata_config {
      node_metadata = "SECURE"
    }
  }

  lifecycle {
    ignore_changes = ["initial_node_count"]
  }
}

resource "google_project_iam_member" "vault" {
  count = "${length(local.gke_service_account_roles)}"

  member  = "serviceAccount:${google_service_account.vault_gke.email}"
  role    = "${element(local.gke_service_account_roles, count.index)}"
  project = "${var.gke_project}"
}
