# IAM Resources for Vault to function
# KMS autounseal https://www.vaultproject.io/docs/configuration/seal/gcpckms.html
# Storage: https://www.vaultproject.io/docs/configuration/storage/google-cloud-storage.html

locals {
  vault_pod_service_account = var.workload_identity_enable ? google_service_account.vault_workload_identity[0].email : google_service_account.vault_gke[0].email
  service_account           = local.gke_pool_create ? local.vault_pod_service_account : var.vault_service_account

  worload_identity_sa_annotation = {
    "iam.gke.io/gcp-service-account" = var.workload_identity_enable ? google_service_account.vault_workload_identity[0].email : ""
  }

  fullname = var.fullname_override != "" ? var.fullname_override : (var.release_name == "vault" ? "vault" : "vault-${var.release_name}")
}

resource "google_service_account" "vault_workload_identity" {
  count = var.workload_identity_enable ? 1 : 0

  account_id   = var.workload_identity_account
  display_name = "Vault Server"
  description  = "Workload Identity Service Account for Vault Server"

  project = coalesce(var.workload_identity_project, var.gke_project)
}

resource "google_service_account_iam_member" "vault_workload_identity" {
  count = var.workload_identity_enable ? 1 : 0

  service_account_id = google_service_account.vault_workload_identity[0].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.gke_project}.svc.id.goog[${var.chart_namespace}/${local.fullname}]"
}

resource "google_project_iam_member" "auto_unseal" {
  project = var.kms_project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:${local.service_account}"
}

resource "google_storage_bucket_iam_member" "storage" {
  bucket = google_storage_bucket.vault.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${local.service_account}"
}
