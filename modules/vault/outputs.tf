output "values" {
  description = "Values from the Vault Helm chart"
  value       = helm_release.vault.metadata[0].values
}

output "release_name" {
  description = "Release name of the Helm chart"
  value       = helm_release.vault.metadata[0].name
}

output "gke_service_account" {
  description = "Email ID of the GKE node pool if created"
  value       = google_service_account.vault_gke.*.email
}

output "gke_service_account_name" {
  description = "Name of the GKE node pool if created"
  value       = google_service_account.vault_gke.*.name
}

output "key_ring_self_link" {
  description = "Self-link of the KMS Keyring created for Vault"
  value       = google_kms_key_ring.vault.self_link
}

output "vault_workload_identity" {
  description = "Email ID of the Vault Workload Identity Service Account if created"
  value       = google_service_account.vault_workload_identity.*.email
}

output "vault_workload_identity_name" {
  description = "Name of the Vault Workload Identity Service Account if created"
  value       = google_service_account.vault_workload_identity.*.name
}
