resource "google_service_account" "certmanager" {
  account_id   = var.certmanager_service_account
  display_name = "Certmanager Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "certmanager" {
  member  = "serviceAccount:${google_service_account.certmanager.email}"
  role    = "roles/dns.admin"
  project = var.project_id
}

resource "google_service_account_key" "certmanager" {
  service_account_id = google_service_account.certmanager.name
}
