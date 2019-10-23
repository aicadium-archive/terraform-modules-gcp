variable "release_name" {
  description = "Helm release name for Vault"
  default     = "vault"
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
  default     = "0.16.0"
}

variable "chart_namespace" {
  description = "Namespace to install the chart into"
  default     = "kube-system"
}

variable "timeout" {
  description = "Time in seconds to wait for any individual kubernetes operation."
  default     = 600
}

variable "replica" {
  description = "Number of Replicas of Vault to run"
  default     = 3
}

variable "fullname_override" {
  description = "Full name of resources"
  default     = "vault"
}

variable "vault_image" {
  description = "Vault Image to run"
  default     = "vault"
}

variable "vault_tag" {
  description = "Vault Image Tag to run"
  default     = "1.0.2"
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
  default     = ""
}

variable "cpu_limit" {
  description = "CPU limit for pods"
  default     = ""
}

variable "memory_limit" {
  description = "Memory limit for pods"
  default     = "4Gi"
}

variable "affinity" {
  description = "Affinity settings for the pods. Can be templated via Helm. The default has Anti affinity for other Vault pods."

  default = {
    podAntiAffinity = {
      requiredDuringSchedulingIgnoredDuringExecution = [
        {
          topologyKey = "kubernetes.io/hostname"
          labelSelector = {
            matchLabels = {
              app     = "{{ template \"vault.name\" . }}"
              release = "{{ .Release.Name }}"
            }
          }
        }
      ]
    }
  }
}

variable "tolerations" {
  description = "List of maps of tolerations for the pod. It is recommend you use this to run Vault on dedicated nodes. See the README"
  default = []
}

variable "node_selector" {
  description = "Node selectors for pods"
  default = {}
}

variable "annotations" {
  description = "Deployment annotations"
  default = {}
}

variable "pod_annotations" {
  description = "Annotations for pods"
  default = {}
}

variable "labels" {
  description = "Additional labels for deployment"
  default = {}
}

variable "container_lifecycle" {
  description = "YAML string of the Vault container lifecycle hooks"
  default = ""
}

variable "pod_priority_class" {
  description = "Pod priority class name. See https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/"
  default = ""
}

variable "min_ready_seconds" {
  description = "Minimum number of seconds that newly created replicas must be ready without any containers crashing"
  default = "0"
}

# Vault Configuration
variable "vault_dev" {
  description = "Run Vault in dev mode"
  default = "false"
}

variable "vault_secret_volumes" {
  description = "List of maps of custom volume mounts that are backed by Kubernetes secrets. The maps should contain the keys `secretName` and `mountPath`."
  default = []
}

variable "vault_env" {
  description = "Extra environment variables for Vault"
  default = []
}

variable "vault_extra_containers" {
  description = "Extra containers for Vault"
  default = []
}

variable "vault_extra_volumes" {
  description = "Additional volumes for Vault"
  default = []
}

variable "vault_extra_volume_mounts" {
  description = "Additional Volume Mounts for Vault"
  default = []
}

variable "vault_log_level" {
  description = "Log level for Vault"
  default = "info"
}

variable "vault_listener_address" {
  description = "Address for the Default Vault listener to bind to"
  default = "[::]"
}

variable "vault_config" {
  description = "Additional Vault configuration. See https://www.vaultproject.io/docs/configuration/. This is requried. The only configuration provided from this module is the listener."
  type = any
}

# Optional Consul Agent
variable "consul_image" {
  description = "Consul Agent image to run"
  default = "consul"
}

variable "consul_tag" {
  description = "Consul Agent image tag to run"
  default = "1.4.2"
}

variable "consul_join" {
  description = "If set, will use this to run a Consul agent sidecar container alongside Vault. You will still need to configure Vault to use this. See https://www.consul.io/docs/agent/options.html#_join for details on this parameter"
  default = ""
}

variable "consul_gossip_secret_key_name" {
  description = "Kubernetes Secret Key holding Consul gossip key"
  default = ""
}

variable "secrets_labels" {
  description = "Labels for secrets"
  default = {}
}

variable "secrets_annotations" {
  description = "Annotations for secrets"
  default = {}
}

variable "tls_cert_pem" {
  description = "PEM encoded certificate for Vault"
}

variable "tls_cert_key" {
  description = "PEM encoded private key for Vault"
}

variable "tls_cipher_suites" {
  description = "Specifies the list of supported ciphersuites as a comma-separated-list. Make sure this matches the type of key of the TLS certificate you are using. See https://golang.org/src/crypto/tls/cipher_suites.go"
  default = "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_AES_128_GCM_SHA256,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA"
}

# KMS Configuration

variable "key_ring_name" {
  description = "Name of the Keyring to create."
  default = "vault"
}

variable "kms_location" {
  description = "Location of the KMS key ring. Must be in the same location as your storage bucket"
}

variable "kms_project" {
  description = "Project ID to create the keyring in"
}

variable "unseal_key_name" {
  description = "Name of the Vault unseal key"
  default = "unseal"
}

variable "unseal_key_rotation_period" {
  description = "Rotation period of the Vault unseal key. Defaults to 6 months"
  default = "15780000s"
}

variable "storage_key_name" {
  description = "Name of the Vault storage key"
  default = "storage"
}

variable "storage_key_rotation_period" {
  description = "Rotation period of the Vault storage key. Defaults to 6 months"
  default = "15780000s"
}

# Storage bucket configuration
variable "storage_bucket_name" {
  description = "Name of the Storage Bucket to store Vault's state"
}

variable "storage_bucket_class" {
  description = "Storage class of the bucket. See https://cloud.google.com/storage/docs/storage-classes"
  default = "REGIONAL"
}

variable "storage_bucket_location" {
  description = "Location of the storage bucket. Defaults to the provider's region if empty. This must be in the same location as your KMS key."
  default = ""
}

variable "storage_bucket_project" {
  description = "Project ID to create the storage bucket under"
}

variable "storage_bucket_labels" {
  description = "Set of labels for the storage bucket"

  default = {
    terraform = "true"
  }
}

variable "storage_ha_enabled" {
  description = "Use the GCS bucket to provide HA for Vault. Set to \"false\" if you are using alternative HA storage like Consul"
  default = "true"
}

# Optional GKE Node pool
variable "gke_pool_create" {
  description = "Whether to create the GKE node pool or not"
  default = false
}

variable "gke_service_account_id" {
  description = "Service Account name for the GKE Node pool"
  default = "vault-gke-pool"
}

variable "gke_project" {
  description = "Project ID where the GKE cluster lives in"
  default = "<REQUIRED if gke_pool_create is true>"
}

variable "gke_pool_name" {
  description = "Name of the GKE Pool name to create"
  default = "vault"
}

variable "gke_pool_region" {
  description = "Region for the GKE cluster if regional"
  default = "<REQUIRED if cluster is regional>"
}

variable "gke_pool_zone" {
  description = "Zone for GKE cluster if zonal"
  default = "<REQUIRED if cluster is zonal>"
}

variable "gke_cluster" {
  description = "Cluster to create node pool for"
  default = "<REQUIRED if gke_pool_create is true>"
}

variable "gke_node_count" {
  description = "Initial Node count. If regional, remember to divide the desired node count by the number of zones"
  default = 3
}

variable "gke_node_size_gb" {
  description = "Disk size for the nodes in GB"
  default = "20"
}

variable "gke_disk_type" {
  description = "Disk type for the nodes"
  default = "pd-standard"
}

variable "gke_machine_type" {
  description = "Machine type for the GKE nodes. Make sure this matches the resources you are requesting"
  default = "n1-standard-2"
}

variable "gke_labels" {
  description = "Labels for the GKE nodes"
  default = {}
}

variable "gke_metadata" {
  description = "Metadata for the GKE nodes"
  default = {}
}

variable "gke_tags" {
  description = "Network tags for the GKE nodes"
  default = []
}

variable "gke_taints" {
  description = "List of map of taints for GKE nodes. It is highly recommended you do set this alongside the pods toleration. See https://www.terraform.io/docs/providers/google/r/container_cluster.html#key for the keys and the README for more information"
  default = []
}

variable "vault_service_account" {
  description = "Required if you did not create a node pool. This should be the service account that is used by the nodes to run Vault workload. They will be given additional permissions to use the keys for auto unseal and to write to the storage bucket"
  default = "<REQUIRED if not creating GKE node pool>"
}
