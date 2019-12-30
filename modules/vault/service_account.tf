# IAM Resources for Vault to function
# KMS autounseal https://www.vaultproject.io/docs/configuration/seal/gcpckms.html
# Storage: https://www.vaultproject.io/docs/configuration/storage/google-cloud-storage.html

locals {
  node_service_account         = local.gke_pool_create ? (var.workload_identity_enable ? google_service_account.vault_gke_pool[0].email : google_service_account.vault_server[0].email) : ""
  vault_server_service_account = local.gke_pool_create ? google_service_account.vault_server[0].email : var.vault_service_account

  worload_identity_sa_annotation = {
    "iam.gke.io/gcp-service-account" = local.gke_pool_create ? google_service_account.vault_server[0].email : ""
  }

  fullname                 = var.fullname_override != "" ? var.fullname_override : (var.release_name == "vault" ? "vault" : "vault-${var.release_name}")
  node_pool_sa_description = "Service Account for the GKE cluster ${var.gke_cluster} - ${var.gke_pool_name} pool"

  vault_server_location = coalesce(var.vault_server_location_description, "<unknown>")
}

# Service account for Vault server. Assigned to GKE nodes if Workload Identity is not enabled
resource "google_service_account" "vault_server" {
  count = local.gke_pool_create ? 1 : 0

  account_id   = var.vault_server_service_account
  display_name = "Vault Server ${local.vault_server_location}"
  description  = "Service Account for Vault Server at ${local.vault_server_location}.${var.workload_identity_enable ? "" : " ${local.node_pool_sa_description}"}"

  project = var.gke_project
}

# Additional service account for Vault GKE nodes if Workload Identity is enabled
resource "google_service_account" "vault_gke_pool" {
  count = local.gke_pool_create && var.workload_identity_enable ? 1 : 0

  account_id   = var.vault_node_service_account
  display_name = "${var.gke_cluster} - ${var.gke_pool_name} GKE Node Pool"
  description  = local.node_pool_sa_description

  project = coalesce(var.workload_identity_project, var.gke_project)
}

# IAM Roles for Vault Node Pool to function
resource "google_project_iam_member" "vault_nodes" {
  for_each = local.gke_pool_create ? toset(local.gke_service_account_roles) : toset([])

  member  = "serviceAccount:${local.node_service_account}"
  role    = each.key
  project = var.gke_project
}

resource "google_service_account_iam_member" "vault_workload_identity" {
  count = local.gke_pool_create && var.workload_identity_enable ? 1 : 0

  service_account_id = google_service_account.vault_server[0].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.gke_project}.svc.id.goog[${var.chart_namespace}/${local.fullname}]"
}

resource "google_project_iam_member" "auto_unseal" {
  project = var.kms_project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:${local.vault_server_service_account}"
}

resource "google_storage_bucket_iam_member" "storage" {
  bucket = google_storage_bucket.vault.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${local.vault_server_service_account}"
}
