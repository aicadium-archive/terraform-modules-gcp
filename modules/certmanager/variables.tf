variable "project_id" {
  description = "Project ID to deploy the cluster to"
}

variable "region" {
  description = "GCP Region"
}

variable "gke_service_account" {
  description = "Email Address of the service Account for GKE"
}

variable "service_namespace" {
  description = "Namespace to run services in"
  default     = "core"
}

variable "labels" {
  description = "Default labels for GCP resources"

  default = {
    terraform = "true"
    app       = "bedrock"
  }
}

variable "internal_static_ip_subnetwork" {
  description = "The self link of the subnetwork to reserve an internal IP address"
}

############################################
# DNS Managed Zone
############################################
variable "dns_managed_zone" {
  description = "Name of the DNS Managed Zone"
  default     = "span-model"
}

variable "dns_base_name" {
  description = "Base DNS Name"
}

variable "external_dns_base_name" {
  description = "Base DNS Name"
  default     = ""
}

variable "base_domain_managed_zone" {
  description = "Managed zone of the base domain for Workload models"
}

variable "base_domain_managed_project" {
  description = "Managed zone project of the base domain for Workload models"
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
