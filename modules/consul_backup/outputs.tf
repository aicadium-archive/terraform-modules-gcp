output "workload_identity_service_account" {
  description = "Email address of the workload identity linked service account"
  value       = var.enable_workload_identity ? google_service_account.workload_identity[0].email : ""
}
