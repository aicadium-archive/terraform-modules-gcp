# Configure a GCP Secrets Engine Roleset

resource "vault_gcp_secret_roleset" "cloudsql" {
  count      = var.enable_vault_agent ? 1 : 0
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

resource "google_project_iam_custom_role" "vault" {
  count = var.enable_vault_agent ? 1 : 0

  role_id = "vault_${var.gcp_role_id}"
  title   = "Vault GCP Secrets Engine IAM role for CloudSQL backup cronjob"

  # https://www.vaultproject.io/docs/secrets/gcp/index.html#required-permissions
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
  count = var.enable_vault_agent ? 1 : 0

  project = var.cloudsql_project
  role    = google_project_iam_custom_role.vault[0].id
  member  = "serviceAccount:${var.gcp_vault_service_account}"
}
