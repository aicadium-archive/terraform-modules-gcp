resource "google_service_account" "workload_identity" {
  count = var.enable_workload_identity ? 1 : 0

  account_id   = var.workload_identity_service_account
  display_name = "Consul Backup"
  description  = "Performs Backup from Consul to GCS"
  project      = var.gcp_bucket_project
}

resource "google_service_account_iam_member" "workload_identity" {
  count = var.enable_workload_identity ? 1 : 0

  service_account_id = google_service_account.workload_identity[0].name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.workload_identity_gke_project}.svc.id.goog[${var.namespace}/${var.service_account_name}]"
}

resource "google_storage_bucket_iam_member" "workload_identity" {
  count = var.enable_workload_identity ? 1 : 0

  bucket = var.gcp_bucket_name
  role   = google_project_iam_custom_role.object_writer.id
  member = "serviceAccount:${google_service_account.workload_identity[0].email}"
}
