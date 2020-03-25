variable "project_id" {
  description = "Project ID to deploy the cluster to"
}

variable "kubeconfig_path" {
  description = "The file path to the kubeconfig"
}

variable "kube_namespace" {
  description = "Namespace to run Certmanager"
  default     = "core"
}

variable "max_history" {
  description = "Max history for Helm"
  default     = 20
}

############################################
# Certificates
############################################
variable "certificates" {
  description = "Certificates to generate"
  type        = list(object({ common_name = string, san = list(string), renew_before = string }))
  default     = []
}

variable "acme_email" {
  description = "Email address to register for ACME account"
}

variable "acme_environment" {
  description = "ACME environment. Either production or staging."
  default     = "staging"
}

############################################
# Cert Manager
############################################

variable "certmanager_enabled" {
  description = "Enable/disable Certmanager"
  default     = true
}

variable "certmanager_service_account" {
  description = "Name of the service account for Certmanager"
  default     = "certmanager"
}

variable "certmanager_crd_version" {
  description = "Version of the CustomResourceDefinition resources for Certmanager. See https://cert-manager.netlify.com/docs/installation/kubernetes/#steps"
  default     = "0.12"
}

variable "certmanager_chart_version" {
  description = "Version of Certmanager helm chart"
  default     = "1.0.1"
}

variable "additional_values" {
  description = "Additional Values for the Helm Chart. (for e.g. values for the underlying dependent chart)"
  default     = []
}
