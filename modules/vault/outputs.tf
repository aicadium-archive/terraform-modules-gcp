output "values" {
  description = "Values from the Vault Helm chart"
  value       = "${helm_release.vault.metadata.0.values}"
}
