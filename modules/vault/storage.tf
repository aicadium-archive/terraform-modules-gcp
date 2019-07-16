resource "google_storage_bucket" "vault" {
  depends_on = [google_project_iam_member.storage_kms]

  name = var.storage_bucket_name
  location = coalesce(
    var.storage_bucket_location,
    data.google_client_config.current.region,
  )

  project       = var.storage_bucket_project
  storage_class = var.storage_bucket_class

  labels = var.storage_bucket_labels

  versioning {
    enabled = true
  }

  encryption {
    default_kms_key_name = google_kms_crypto_key.storage.self_link
  }
  # For future Terraform 0.12 when we can "unset" this
  # logging {}
}

resource "google_project_iam_member" "storage_kms" {
  project = var.storage_bucket_project
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:${data.google_storage_project_service_account.vault.email_address}"
}
