resource "google_service_account" "certmanager" {
  count = local.certmanager_enabled

  account_id   = var.certmanager_service_account
  display_name = "Certmanager Service Account"
  project      = var.project_id
}

resource "google_project_iam_member" "certmanager" {
  count = local.certmanager_enabled

  member  = "serviceAccount:${google_service_account.certmanager[0].email}"
  role    = "roles/dns.admin"
  project = var.project_id
}

resource "google_service_account_key" "certmanager" {
  count = local.certmanager_enabled

  service_account_id = google_service_account.certmanager[0].name
}
