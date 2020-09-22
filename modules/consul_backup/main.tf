resource "helm_release" "consul_backup" {
  name       = var.release_name
  chart      = var.chart_name
  repository = var.chart_repository_url
  version    = var.chart_version
  namespace  = var.namespace

  max_history = var.max_history

  values = [
    templatefile("${path.module}/templates/values.yaml", local.values),
  ]
}

locals {
  values = {
    schedule = var.schedule
    env      = jsonencode(var.env)

    image       = var.image
    tag         = var.tag
    pull_policy = var.pull_policy

    consul_address = var.consul_address

    node_selector = jsonencode(var.node_selector)
    tolerations   = jsonencode(var.tolerations)
    affinity      = jsonencode(var.affinity)

    gcs_bucket = var.gcp_bucket_name
    gcs_prefix = var.gcs_prefix

    service_account_key = var.create_service_account_key ? jsonencode(google_service_account_key.key[0].private_key) : "null"

    service_account = var.service_account_name
    service_account_annotations = jsonencode(var.enable_workload_identity ? {
      "iam.gke.io/gcp-service-account" = var.enable_workload_identity ? google_service_account.workload_identity[0].email : ""
    } : {})

    ttl_seconds = var.ttl_seconds
  }
}

resource "google_project_iam_custom_role" "object_writer" {
  role_id     = var.gcp_role_id
  title       = var.gcp_role_title
  description = var.gcp_role_description

  permissions = [
    "storage.objects.create",
    "storage.objects.list",
  ]

  project = var.gcp_bucket_project
}

resource "google_service_account" "workload_identity" {
  count = var.enable_workload_identity || var.create_service_account_key ? 1 : 0

  account_id   = var.workload_identity_service_account
  display_name = "Consul Backup"
  description  = "Performs Backup from Consul to GCS"
  project      = var.gcp_bucket_project
}

resource "google_service_account_key" "key" {
  count              = var.create_service_account_key ? 1 : 0
  service_account_id = google_service_account.workload_identity[0].name
}
