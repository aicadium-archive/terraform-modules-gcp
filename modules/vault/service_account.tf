# KMS autounseal https://www.vaultproject.io/docs/configuration/seal/gcpckms.html
# Storage: https://www.vaultproject.io/docs/configuration/storage/google-cloud-storage.html

locals {
  service_account = local.gke_pool_create ? google_service_account.vault_gke[0].email : var.vault_service_account
}

resource "google_project_iam_member" "auto_unseal" {
  project = var.kms_project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:${local.service_account}"
}

resource "google_project_iam_member" "storage" {
  project = var.storage_bucket_project
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${local.service_account}"
}
