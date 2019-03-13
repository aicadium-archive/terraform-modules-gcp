variable "gcp_secrets_path" {
  description = "Path to the GCP Secrets Engine in Vault"
  default     = "gcp"
}

variable "gcp_secrets_roleset" {
  description = "Name of the GCP Secrets Roleset to create"
  default     = "consul_backup"
}

variable "gcp_bucket_project" {
  description = "Project where the backup bucket is stored in"
}

variable "gcp_bucket_name" {
  description = "GCS Storage bucket name"
}

variable "gcp_role_id" {
  description = "Name of the custom role to allow only creator access to bucket"
  default     = "object-creator"
}

variable "gcp_role_title" {
  description = "Title of the custom role to allow only creator access to bucket"
  default     = "Bucket Object Creator"
}

variable "gcp_role_description" {
  description = "Description for the custom role to allow only creator access to bucket"
  default     = "Create objects in buckets."
}

variable "gcp_vault_role_id" {
  description = "Name of the custom role to allow Vault to manage bucket IAM permissions"
  default     = "vault-bucket-iam"
}

variable "gcp_vault_role_title" {
  description = "Title of the custom role to allow Vault to manage bucket IAM permissions"
  default     = "Vault Bucket IAM Manager"
}

variable "gcp_vault_role_description" {
  description = "Description for the custom role to allow Vault to manage bucket IAM permissions"
  default     = "Allow Vault to manage bucket IAM permissions"
}

variable "gcp_vault_service_account" {
  description = "Service account email for Vault for the GCP secrets engine"
}

variable "kubernetes_auth_path" {
  description = "Path to the Kubernetes Auth Engine"
  default     = "kubernetes"
}

variable "kubernetes_auth_role_name" {
  description = "Name of the Kubernetes Auth Backend Role"
  default     = "consul_backup"
}

variable "service_account_name" {
  description = "Name of the service account for the backup job"
  default     = "consul-backup"
}

variable "namespace" {
  description = "Namespace to run the backup job in"
  default     = "default"
}

variable "vault_ttl" {
  description = "TTL for the Vault Token"
  default     = "300"
}

variable "vault_policy" {
  description = "Name of the policy for Vault"
  default     = "consul_backup"
}
