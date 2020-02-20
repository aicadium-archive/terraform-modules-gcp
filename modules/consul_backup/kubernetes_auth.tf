locals {
  gcp_secret_path = var.enable_vault_agent ? "${vault_gcp_secret_roleset.bucket[0].backend}/key/${vault_gcp_secret_roleset.bucket[0].roleset}" : ""
}

resource "vault_kubernetes_auth_backend_role" "job" {
  count = var.enable_vault_agent ? 1 : 0

  backend   = var.kubernetes_auth_path
  role_name = var.kubernetes_auth_role_name

  bound_service_account_names      = [var.service_account_name]
  bound_service_account_namespaces = [var.namespace]

  token_ttl      = var.vault_ttl
  token_max_ttl  = var.vault_ttl
  token_policies = [vault_policy.job[0].name]
}

data "vault_policy_document" "job" {
  count = var.enable_vault_agent ? 1 : 0

  rule {
    path         = local.gcp_secret_path
    capabilities = ["read"]
  }
}

resource "vault_policy" "job" {
  count = var.enable_vault_agent ? 1 : 0

  name   = var.vault_policy
  policy = data.vault_policy_document.job[0].hcl
}
