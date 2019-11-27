variable "project_id" {
  description = "Project ID to deploy the cluster to"
}

variable "kube_context" {
  description = "Kubernetes context"
}

variable "kube_namespace" {
  description = "Namespace to run Certmanager"
  default     = "core"
}

############################################
# Certificates
############################################
variable "certificates" {
  description = "Certificates to generate"
  type        = list(object(any))
  default     = []
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
