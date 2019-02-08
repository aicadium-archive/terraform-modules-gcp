variable "release_name" {
  description = "Helm release name for Traefik"
  default     = "traefik"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "incubator/vault"
}

variable "chart_repository" {
  description = "Helm repository for the chart"
  default     = ""
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version"
  default     = "0.14.7"
}

variable "chart_namespace" {
  description = "Namespace to install the chart into"
  default     = "kube-system"
}

variable "replica" {
  description = "Number of Replicas of Vault to run"
  default     = 3
}

variable "vault_image" {
  description = "Vault Image to run"
  default     = "vault"
}

variable "vault_tag" {
  description = "Vault Image Tag to run"
  default     = "0.11.6"
}

variable "service_name" {
  description = "Name of service for Vault"
  default     = "vault"
}

variable "service_type" {
  description = "Service type for Vault"
  default     = "ClusterIP"
}

variable "load_balancer_ip" {
  description = "Static Load balancer IP if needed"
  default     = ""
}

variable "load_balancer_source_ranges" {
  description = "Restrict the CIDRs that can access the load balancer"
  default     = []
}

variable "service_external_port" {
  description = "Service external Port"
  default     = 8200
}

variable "service_port" {
  description = "Service port"
  default     = 8200
}

variable "service_cluster_ip" {
  description = "Cluster Service IP if needed"
  default     = ""
}

variable "service_annotations" {
  description = "Annotations for the service"
  default     = {}
}

variable "ingress_enabled" {
  description = "Enable ingress"
  default     = "false"
}

variable "ingress_labels" {
  description = "Labels for ingress"
  default     = {}
}

variable "ingress_hosts" {
  description = "Name of hosts for ingress"
  default     = []
}

variable "ingress_annotations" {
  description = "Annotations for ingress"
  default     = {}
}

variable "ingress_tls" {
  description = "Ingress TLS settings"
  default     = {}
}

variable "cpu_request" {
  description = "CPU request for pods"
  default     = "500m"
}

variable "memory_request" {
  description = "Memory request for pods"
  default     = "2Gi"
}

variable "cpu_limit" {
  description = "CPU limit for pods"
  default     = "2000m"
}

variable "memory_limit" {
  description = "Memory limit for pods"
  default     = "4Gi"
}

variable "affinity" {
  description = "Affinity settings for the pods in YAML"
  default     = ""
}

variable "annotations" {
  description = "Deployment annotations"
  default     = {}
}

variable "pod_annotations" {
  description = "Annotations for pods"
  default     = {}
}

variable "labels" {
  description = "Additional labels for deployment"
  default     = {}
}

variable "lifecycle" {
  description = "YAML string of the Vault container lifecycle hooks"
  default     = ""
}

# Vault Configuration
variable "vault_dev" {
  description = "Run Vault in dev mode"
  default     = "false"
}

variable "vault_secret_volumes" {
  description = "List of maps of custom volume mounts that are backed by Kubernetes secrets. The maps should contain the keys `secretName` and `mountPath`."
  default     = []
}

variable "vault_env" {
  description = "Extra environment variables for Vault"
  default     = {}
}

variable "vault_extra_containers" {
  description = "Extra containers for Vault"
  default     = {}
}

variable "vault_extra_volumes" {
  description = "Additional volumes for Vault"
  default     = {}
}

variable "vault_log_level" {
  description = "Log level for Vault"
  default     = "info"
}

variable "vault_listener_address" {
  description = "Address for the Default Vault listener to bind to"
  default     = "[::]"
}

variable "vault_config" {
  description = "Additional Vault configuration. See https://www.vaultproject.io/docs/configuration/. This is requried. The only configuration provided from this module is the listener."
  type        = "map"
}

# Optional Consul Agent
variable "consul_image" {
  description = "Consul Agent image to run"
  default     = "consul"
}

variable "consul_tag" {
  description = "Consul Agent image tag to run"
  default     = "1.4.2"
}

variable "consul_join" {
  description = "If set, will use this to run a Consul agent sidecar container alongside Vault. You will still need to configure Vault to use this. See https://www.consul.io/docs/agent/options.html#_join for details on this parameter"
  default     = ""
}

variable "consul_gossip_secret_key_name" {
  description = "Kubernetes Secret Key holding Consul gossip key"
  default     = ""
}

variable "secrets_labels" {
  description = "Labels for secrets"
  default     = {}
}

variable "secrets_annotations" {
  description = "Annotations for secrets"
  default     = {}
}

variable "tls_cert_pem" {
  description = "PEM encoded certificate for Vault"
}

variable "tls_cert_key" {
  description = "PEM encoded private key for Vault"
}
