data "google_client_config" "current" {
}

data "google_storage_project_service_account" "vault" {
  project = var.storage_bucket_project
}

