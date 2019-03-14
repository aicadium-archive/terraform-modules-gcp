# Configure a GCP Secrets Engine Roleset

locals {
  vault_iam_roles = [
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountKeyAdmin",
    "projects/${var.gcp_bucket_project}/roles/${google_project_iam_custom_role.vault.role_id}",
  ]
}

resource "vault_gcp_secret_roleset" "bucket" {
  depends_on = [
    "google_project_iam_member.vault",
  ]

  backend      = "${var.gcp_secrets_path}"
  roleset      = "${var.gcp_secrets_roleset}"
  secret_type  = "service_account_key"
  project      = "${var.gcp_bucket_project}"
  token_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

  binding {
    resource = "buckets/${var.gcp_bucket_name}"

    roles = [
      "projects/${var.gcp_bucket_project}/roles/${google_project_iam_custom_role.object_writer.role_id}",
    ]
  }
}

resource "google_project_iam_custom_role" "object_writer" {
  role_id     = "${var.gcp_role_id}"
  title       = "${var.gcp_role_title}"
  description = "${var.gcp_role_description}"

  permissions = [
    "storage.objects.create",
    "storage.objects.list",
  ]

  project = "${var.gcp_bucket_project}"
}

resource "google_project_iam_custom_role" "vault" {
  role_id     = "${var.gcp_vault_role_id}"
  title       = "${var.gcp_vault_role_title}"
  description = "${var.gcp_vault_role_description}"

  permissions = [
    "storage.buckets.getIamPolicy",
    "storage.buckets.setIamPolicy",
  ]

  project = "${var.gcp_bucket_project}"
}

resource "google_project_iam_member" "vault" {
  count = "${length(local.vault_iam_roles)}"

  project = "${var.gcp_bucket_project}"
  role    = "${element(local.vault_iam_roles, count.index)}"
  member  = "serviceAccount:${var.gcp_vault_service_account}"
}
