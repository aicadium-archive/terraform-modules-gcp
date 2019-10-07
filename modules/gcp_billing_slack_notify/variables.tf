#####################
# Chart settings
#####################

variable "release_name" {
  description = "Helm release name for Vault"
  default     = "gcp-billing-slack-notify"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "gcp-billing-slack-notify"
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
  default     = "0.1.0"
}

variable "namespace" {
  description = "Namespace to run the backup job in"
  default     = "core"
}

#####################
# Chart values
#####################

variable "schedule" {
  description = "Cron schedule of job in UTC"
  default     = "0 3 * * *"
}

variable "ttl_seconds" {
  description = "TTL of jobs in seconds. Set to an empty string to disable"
  default     = 86400
}

variable "image" {
  description = "Docker image of the backup job"
  default     = "basisai/gcp-billing-slack-notify"
}

variable "tag" {
  description = "Docker image tag of the backup job"
  default     = "0.1.1"
}

variable "pull_policy" {
  description = "Image pull policy of the backup job"
  default     = "IfNotPresent"
}

variable "gcp_billing_account_id" {
  description = "GCP billing account ID that manages projects' spendings"
}

variable "gcp_project_ids" {
  description = "GCP project IDs to calculate spending"
}

variable "gcp_sa_key" {
  description = "GCP service account key used to execute BigQuery queries"
}

variable "slack_webhook" {
  description = "Slack webhook to send notifications to Slack"
}

variable "resources" {
  description = "Resources used by the job"
  default     = {
    limits = {
      cpu = "200m"
      memory = "256Mi"
    }
    requests = {
      cpu = "100m"
      memory = "256Mi"
  }
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

variable "labels" {
  description = "Labels for the job"
  default     = {}
}

variable "annotations" {
  description = "Annotations for the job"
  default     = {}
}
