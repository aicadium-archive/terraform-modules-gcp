locals {
  gcp_secret_path = "${vault_gcp_secret_roleset.bucket.backend}/key/${vault_gcp_secret_roleset.bucket.roleset}"
}

resource "vault_kubernetes_auth_backend_role" "job" {
  backend   = "${var.kubernetes_auth_path}"
  role_name = "${var.kubernetes_auth_role_name}"

  bound_service_account_names      = ["${var.service_account_name}"]
  bound_service_account_namespaces = ["${var.namespace}"]

  ttl      = "${var.vault_ttl}"
  max_ttl  = "${var.vault_ttl}"
  policies = ["${vault_policy.job.name}"]
}

data "vault_policy_document" "job" {
  rule {
    path         = "${local.gcp_secret_path}"
    capabilities = ["read"]
  }
}

resource "vault_policy" "job" {
  name   = "${var.vault_policy}"
  policy = "${data.vault_policy_document.job.hcl}"
}
