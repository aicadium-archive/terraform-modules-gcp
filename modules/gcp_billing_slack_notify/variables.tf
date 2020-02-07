variable "billing_bigquery_project_id" {
  description = "GCP Project ID where the Bigquery dataset resides"
}

variable "billing_bigquery_service_account" {
  description = "GCP service account with permissions to access the bigquery dataset"
}

#####################
# Chart settings
#####################
variable "enabled" {
  description = "Enable/disable chart"
  default     = true
}

variable "release_name" {
  description = "Helm release name"
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
  default     = "0.1.1"
}

variable "namespace" {
  description = "Namespace to run the job in"
  default     = "core"
}

variable "max_history" {
  description = "Max history for Helm"
  default     = 20
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
  description = "Docker image tag of the job"
  default     = "0.1.1"
}

variable "pull_policy" {
  description = "Image pull policy of the job"
  default     = "IfNotPresent"
}

variable "gcp_billing_account_id" {
  description = "GCP billing account ID that manages projects' spendings"
}

variable "gcp_project_ids" {
  description = "GCP project IDs to calculate spending"
  type        = list(string)
}

variable "slack_webhook" {
  description = "Slack webhook to send notifications to Slack"
}

variable "resources" {
  description = "Resources used by the job"
  default = {
    limits = {
      cpu    = "200m"
      memory = "256Mi"
    }
    requests = {
      cpu    = "100m"
      memory = "256Mi"
    }
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
