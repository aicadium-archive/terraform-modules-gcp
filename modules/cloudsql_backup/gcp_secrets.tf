# Configure a GCP Secrets Engine Roleset

resource "vault_gcp_secret_roleset" "bucket" {
  depends_on = [google_project_iam_member.vault]

  backend      = var.gcp_secrets_path
  roleset      = var.gcp_secrets_roleset
  secret_type  = "service_account_key"
  project      = var.cloudsql_project
  token_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

  binding {
    resource = "//cloudresourcemanager.googleapis.com/projects/${var.cloudsql_project}"

    roles = [
      "projects/${var.cloudsql_project}/roles/${google_project_iam_custom_role.backup.role_id}",
    ]
  }
}

resource "google_project_iam_custom_role" "backup" {
  role_id     = var.gcp_role_id
  title       = var.gcp_role_title
  description = var.gcp_role_description

  permissions = [
    "cloudsql.backupRuns.create",
    "cloudsql.instances.get",
  ]

  project = var.cloudsql_project
}

resource "google_project_iam_custom_role" "vault" {
  role_id = "vault_${gcp_role_id}"
  title   = "Vault GCP Secrets Engine IAM role for CloudSQL backup"

  permissions = [
    "iam.serviceAccounts.create",
    "iam.serviceAccounts.delete",
    "iam.serviceAccounts.get",
    "iam.serviceAccounts.list",
    "iam.serviceAccounts.update",
    "iam.serviceAccountKeys.create",
    "iam.serviceAccountKeys.delete",
    "iam.serviceAccountKeys.get",
    "iam.serviceAccountKeys.list",
    "resourcemanager.projects.getIamPolicy",
    "resourcemanager.projects.setIamPolicy",
  ]

  project = var.cloudsql_project
}

resource "google_project_iam_member" "vault" {
  project = var.cloudsql_project
  role    = google_project_iam_custom_role.vault.id
  member  = "serviceAccount:${var.gcp_vault_service_account}"
}
