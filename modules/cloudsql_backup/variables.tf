variable "release_name" {
  description = "Helm release name for Vault"
  default     = "cloudsql-backup"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "gcloud-cron"
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

variable "max_history" {
  description = "Max history for Helm"
  default     = 20
}

variable "enable_vault_agent" {
  description = "Enable using Vault agent for retrieving GCP credentials "
  default     = false
}

variable "vault_address" {
  description = "Address for Vault"
  default     = ""
}

variable "vault_ca" {
  description = "PEM encoded Vault CA certificate"
  default     = ""
}

variable "gcp_secrets_path" {
  description = "Path to the GCP Secrets Engine in Vault"
  default     = "gcp"
}

variable "gcp_secrets_roleset" {
  description = "Name of the GCP Secrets Roleset to create"
  default     = "cloudsql_backup"
}

variable "cloudsql_project" {
  description = "Project where the CloudSQL instance is in"
}

variable "cloudsql_instance" {
  description = "Name of the Cloud SQL Instance"
}

variable "gcp_role_id" {
  description = "Name of the custom role to allow only creator access to bucket"
  default     = "cloudSqlBackup"
}

variable "gcp_role_title" {
  description = "Title of the custom role to allow only creator access to bucket"
  default     = "Cloud SQL Backup Creator"
}

variable "gcp_role_description" {
  description = "Description for the custom role to allow only creator access to bucket"
  default     = "Create backup runs for Cloud SQL instances."
}

variable "gcp_vault_service_account" {
  description = "Service account email for Vault for the GCP secrets engine"
  default     = ""
}

variable "kubernetes_auth_path" {
  description = "Path to the Kubernetes Auth Engine"
  default     = "kubernetes"
}

variable "kubernetes_auth_role_name" {
  description = "Name of the Kubernetes Auth Backend Role"
  default     = "cloudsql_backup"
}

variable "service_account_name" {
  description = "Name of the service account for the backup job"
  default     = "cloudsql-backup"
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
  default     = "cloudsql_backup"
}

variable "schedule" {
  description = "Cron schedule of job in UTC"
  default     = "0 3 * * *"
}

variable "image" {
  description = "Docker image of the backup job"
  default     = "google/cloud-sdk"
}

variable "tag" {
  description = "Docker image tag of the backup job"
  default     = "251.0.0-alpine"
}

variable "pull_policy" {
  description = "Image pull policy of the backup job"
  default     = "IfNotPresent"
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
  description = "Additional environment variables for the Gcloud Job"
  default     = []
}

variable "enable_workload_identity" {
  description = "Enable Workload Identity for GCP credentials"
  default     = false
}

variable "workload_identity_service_account" {
  description = "Name of the GCP Service account for Workload Identity"
  default     = "cloudsql-backup"
}

variable "workload_identity_gke_project" {
  description = "GCP Project where the GKE cluster is located in"
  default     = ""
}

variable "entrypoint" {
  description = "Override Entrypoint of the container"
  default     = ""
}
