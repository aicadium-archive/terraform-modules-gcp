variable "release_name" {
  description = "Helm release name"
  default     = "consul-backup"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "consul-backup-gcs"
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

variable "service_account_name" {
  description = "Name of the service account for the backup job"
  default     = "consul-backup"
}

variable "namespace" {
  description = "Namespace to run the backup job in"
  default     = "default"
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
  default     = "0.3.3"
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

variable "create_service_account_key" {
  description = "Create Service account key for use with Chart"
  default     = false
}

variable "enable_workload_identity" {
  description = "Enable Workload Identity for GCP credentials"
  default     = false
}

variable "workload_identity_service_account" {
  description = "Name of the GCP Service account for Workload Identity"
  default     = "consul-backup"
}

variable "workload_identity_gke_project" {
  description = "GCP Project where the GKE cluster is located in"
  default     = ""
}
