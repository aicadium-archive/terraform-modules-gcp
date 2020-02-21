output "vault_roleset_service_account" {
  description = "Email address of the GCP Secrets Engine Service account"
  value       = var.enable_vault_agent ? vault_gcp_secret_roleset.bucket[0].service_account_email : ""
}

output "workload_identity_service_account" {
  description = "Email address of the workload identity linked service account"
  value       = var.enable_workload_identity ? google_service_account.workload_identity[0].email : ""
}
