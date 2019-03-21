# Configure a GCP Secrets Engine Roleset

locals {
  vault_iam_roles = [
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountKeyAdmin",
    "roles/resourcemanager.projectIamAdmin",
  ]
}

resource "vault_gcp_secret_roleset" "bucket" {
  depends_on = [
    "google_project_iam_member.vault",
  ]

  backend      = "${var.gcp_secrets_path}"
  roleset      = "${var.gcp_secrets_roleset}"
  secret_type  = "service_account_key"
  project      = "${var.cloudsql_project}"
  token_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

  binding {
    resource = "//cloudresourcemanager.googleapis.com/projects/${var.cloudsql_project}"

    roles = [
      "projects/${var.cloudsql_project}/roles/${google_project_iam_custom_role.backup.role_id}",
    ]
  }
}

resource "google_project_iam_custom_role" "backup" {
  role_id     = "${var.gcp_role_id}"
  title       = "${var.gcp_role_title}"
  description = "${var.gcp_role_description}"

  permissions = [
    "cloudsql.backupRuns.create",
    "cloudsql.instances.get",
  ]

  project = "${var.cloudsql_project}"
}

resource "google_project_iam_member" "vault" {
  count = "${length(local.vault_iam_roles)}"

  project = "${var.cloudsql_project}"
  role    = "${element(local.vault_iam_roles, count.index)}"
  member  = "serviceAccount:${var.gcp_vault_service_account}"
}
