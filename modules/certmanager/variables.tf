variable "project_id" {
  description = "Project ID to deploy the cluster to"
}

variable "kube_context" {
  description = "Kubernetes context"
}

variable "service_namespace" {
  description = "Namespace to run services in"
  default     = "core"
}

############################################
# DNS Managed Zone
############################################
variable "dns_base_name" {
  description = "Base DNS Name"
}

variable "external_dns_base_name" {
  description = "Base DNS Name"
  default     = ""
}

variable "acme_email" {
  description = "Email address to register for ACME account"
}

############################################
# Cert Manager
############################################

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
  default     = "1.0.0"
}

variable "certificate_renew_before" {
  description = "Duration in advance to renew cert before expiry. Must only be specifed using s, m, and h suffixes (seconds, minutes and hours respectively)."
  default     = "720h"
}
