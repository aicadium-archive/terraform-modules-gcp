variable "release_name" {
  description = "Helm release name for Vault"
  default     = "consul-backup"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "consul-backup-gcs"
}

variable "chart_repository" {
  description = "Helm repository for the chart"
  default     = "amoy"
}

variable "chart_repository_url" {
  description = "URL of the Chart Repository"
  default     = "https://charts.amoy.ai"
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version"
  default     = ""
}

variable "vault_address" {
  description = "Address for Vault"
}

variable "vault_ca" {
  description = "PEM encoded Vault CA certificate"
}

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

variable "gcs_prefix" {
  description = "Prefix for backup snapshots in the GCS bucket"
  default     = "backup/consul/"
}

variable "gcp_role_id" {
  description = "Name of the custom role to allow only creator access to bucket"
  default     = "objectCreator"
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
  default     = "vaultBucketIam"
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
  default     = "600"
}

variable "vault_policy" {
  description = "Name of the policy for Vault"
  default     = "consul_backup"
}

variable "schedule" {
  description = "Cron schedule of job in UTC"
  default     = "0 3 * * *"
}

variable "image" {
  description = "Docker image of the backup job"
  default     = "basisai/consul-backup-gcs"
}

variable "tag" {
  description = "Docker image tag of the backup job"
  default     = "0.2.0"
}

variable "pull_policy" {
  description = "Image pull policy of the backup job"
  default     = "IfNotPresent"
}

variable "consul_address" {
  description = "Address of Consul server"
  default     = "consul-server.service.consul:8500"
}

variable "node_selector" {
  description = "Node selector for the job"
  default     = {}
}

variable "tolerations" {
  description = "Tolerations for the job"
  default     = []
}

variable "affinity" {
  description = "Affinity for the job"
  default     = {}
}

variable "ttl_seconds" {
  description = "TTL of jobs in seconds. Set to an empty string to disable"
  default     = ""
}

variable "env" {
  description = "Additional environment variables for the Ansible playbook"
  default     = []
}
