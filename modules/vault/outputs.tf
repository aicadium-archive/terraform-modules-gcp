output "values" {
  description = "Values from the Vault Helm chart"
  value       = "${helm_release.vault.metadata.0.values}"
}

output "gke_service_account" {
  description = "Email ID of the GKE node pool if created"
  value       = "${google_service_account.vault_gke.*.email}"
}
