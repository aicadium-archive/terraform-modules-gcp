variable "labels" {
  description = "Labels for GCP resources"
  default = {
    terraform = "true"
    usage     = "vault"
  }
}

variable "project_id" {
  description = "Project ID for GCP Resources"
}

#############################
# Helm Resources
#############################
variable "release_name" {
  description = "Helm release name for Vault"
  default     = "vault"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "https://github.com/hashicorp/vault-helm/archive/master.tar.gz"
}

variable "chart_repository" {
  description = "Helm repository for the chart"
  default     = ""
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version"
  default     = ""
}

variable "max_history" {
  description = "Max history for Helm"
  default     = 20
}

variable "timeout" {
  description = "Time in seconds to wait for any individual kubernetes operation."
  default     = 600
}

variable "fullname_override" {
  description = "Helm resources full name override"
  type        = string
  default     = ""
}

#############################
# Chart Configuration
#############################
variable "global_enabled" {
  description = "Globally enable or disable chart resources"
  default     = true
}

variable "tls_disabled" {
  description = "Disable TLS for Vault"
  default     = false
}

variable "injector_enabled" {
  description = "Enable Vault Injector"
  default     = true
}

variable "external_vault_addr" {
  description = "External vault server address for the injector to use. Setting this will disable deployment of a vault server along with the injector."
  default     = ""
}

variable "injector_image_repository" {
  description = "Image repository for Vault Injector"
  default     = "hashicorp/vault-k8s"
}

variable "injector_image_tag" {
  description = "Image tag for Vault Injector"
  default     = "0.3.0"
}

variable "injector_log_level" {
  description = "Log level for the injector. Supported log levels: trace, debug, error, warn, info"
  default     = "info"
}

variable "injector_log_format" {
  description = "Log format for the injector. standard or json"
  default     = "standard"
}

variable "injector_resources" {
  description = "Resources for the injector"
  default = {
    requests = {
      memory = "256Mi"
      cpu    = "250m"
    }
    limits = {
      memory = "256Mi"
      cpu    = "250m"
    }
  }
}

variable "injector_env" {
  description = "Extra environment variable for the injector pods"
  default     = {}
}

variable "injector_affinity" {
  description = "YAML string for injector pod affinity"
  default     = ""
}

variable "injector_tolerations" {
  description = "YAML string for injector tolerations"
  default     = ""
}

variable "injector_priority_class_name" {
  description = "Priority class name for injector pods"
  default     = ""
}

variable "agent_image_repository" {
  description = "Image repository for the Vault agent that is injected"
  default     = "vault"
}

variable "agent_image_tag" {
  description = "Image tag for the Vault agent that is injected"
  default     = "1.4.0"
}

variable "auth_path" {
  description = "Mount path of the Kubernetes Auth Engine that the injector will use"
  default     = "auth/kubernetes"
}

variable "revoke_on_shutdown" {
  description = "Attempt to revoke Vault Token on injected agent shutdown."
  default     = true
}

variable "namespace_selector" {
  description = "The selector for restricting the webhook to only specific namespaces. See https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/#matching-requests-namespaceselector for more details."
  default     = {}
}

variable "server_replicas" {
  description = "Number of replicas. Should be either 3 or 5 for raft"
  default     = 5
}

variable "server_image_repository" {
  description = "Server image repository"
  default     = "vault"
}

variable "server_image_tag" {
  description = "Server image tag"
  default     = "1.4.0"
}

variable "server_update_strategy" {
  description = "Configure the Update Strategy Type for the StatefulSet. See https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#update-strategies"
  default     = "RollingUpdate"
}

variable "server_labels" {
  description = "Labels for server"
  default     = {}
}

variable "server_annotations" {
  description = "Annotations for server"
  default     = {}
}

variable "server_resources" {
  description = "Resources for server pods"
  default = {
    requests = {
      memory = "256Mi"
      cpu    = "250m"
    }
    limits = {
      memory = "256Mi"
      cpu    = "250m"
    }
  }
}

variable "server_extra_containers" {
  description = "Extra containers for Vault server as a raw YAML string"
  default     = ""
}

variable "server_extra_args" {
  description = "Extra args for the server"
  default     = ""
}

variable "server_share_pid" {
  description = "Share PID for server pods"
  default     = false
}

variable "server_env" {
  description = "Server extra environment variables"
  default     = {}
}

variable "server_secret_env" {
  description = "Extra secret environment variables for server"
  default     = []
}

variable "server_volumes" {
  description = "Extra volumes for server"
  default     = []
}

variable "server_affinity" {
  description = "Server affinity YAML string"
  default     = <<EOF
podAntiAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - labelSelector:
        matchLabels:
          app.kubernetes.io/name: {{ template "vault.name" . }}
          app.kubernetes.io/instance: "{{ .Release.Name }}"
          component: server
      topologyKey: kubernetes.io/hostname
EOF
}

variable "server_tolerations" {
  description = "YAML string for server tolerations"
  default     = ""
}

variable "server_priority_class_name" {
  description = "Priority class name for server pods"
  default     = ""
}

variable "server_readiness_probe_enable" {
  description = "Enable server readiness probe"
  default     = true
}

variable "server_readiness_probe_path" {
  description = "Path for server readiness probe"
  default     = ""
}

variable "server_liveness_probe_enable" {
  description = "Enable server liness probe"
  default     = true
}

variable "server_liveness_probe_path" {
  description = "Server liveness probe path"
  default     = "/v1/sys/health?standbyok=true"
}

variable "enable_auth_delegator" {
  description = "uthDelegator enables a cluster role binding to be attached to the service account.  This cluster role binding can be used to setup Kubernetes auth method. https://www.vaultproject.io/docs/auth/kubernetes.html"
  default     = true
}

variable "raft_set_node_id" {
  description = "Set Raft Node ID as the name of the vault pod"
  default     = true
}

variable "service_type" {
  description = "Service type for Vault"
  default     = "ClusterIP"
}

variable "node_port" {
  description = "If type is set to 'NodePort', a specific nodePort value can be configured, will be random if left blank."
  default     = "30000"
}

variable "load_balancer_ip" {
  description = "LoadBalancer IP, if any for Vault service"
  default     = ""
}

variable "load_balancer_source_ranges" {
  description = "Allowed source rangers for LoadBalancer service"
  default     = []
}

variable "active_vault_pod_only" {
  description = "Configure service to select active Vault pod only"
  default     = false
}

variable "service_annotations" {
  description = "Annotations for the service"
  default     = {}
}

variable "ingress_enabled" {
  description = "Enable ingress for the server"
  default     = false
}

variable "ingress_labels" {
  description = "Labels for server ingress"
  default     = {}
}

variable "ingress_annotations" {
  description = "Annotations for server ingress"
  default     = {}
}

variable "ingress_hosts" {
  description = "Hosts for server ingress"
  default = [
    {
      host  = "chart-example.local"
      paths = []
    }
  ]
}

variable "ingress_tls" {
  description = "Configuration for server ingress"
  default     = []
}

#############################
# Vault Server Configuration
#############################
variable "tls_cert_pem" {
  description = "PEM encoded certificate for Vault"
}

variable "tls_cert_key" {
  description = "PEM encoded private key for Vault"
}

variable "tls_cipher_suites" {
  description = "Specifies the list of supported ciphersuites as a comma-separated-list. Make sure this matches the type of key of the TLS certificate you are using. See https://golang.org/src/crypto/tls/cipher_suites.go"
  default     = ""
}


variable "vault_api_addr" {
  description = "This is the address (full URL) to advertise to other Vault servers in the cluster for client redirection. See https://www.vaultproject.io/docs/configuration/#api_addr."
  default     = ""
}

variable "vault_cluster_addr" {
  description = "Vault cluster addr"
  default     = ""
}

variable "unauthenticated_metrics_access" {
  description = "If set to true, allows unauthenticated access to the /v1/sys/metrics endpoint."
  default     = false
}

variable "server_config" {
  description = "Additional server configuration"
  default     = {}
}

#############################
# Kubernetes Resources
#############################
variable "kubernetes_namespace" {
  description = "Namespace for Kubernetes resources"
  default     = "default"
}

variable "kubernetes_annotations" {
  description = "Annotations for Kubernetes in general"
  default     = {}
}

variable "kubernetes_labels" {
  description = "Labels for Kubernetes in general"
  default = {
    terraform = "true"
    app       = "vault"
  }
}

#############################
# Raft Storage
#############################
variable "raft_storage_enable" {
  description = "Enable the use of Raft Storage"
  default     = true
}

variable "raft_region" {
  description = "GCP Region for Raft Disk resources"
  default     = ""
}

variable "raft_persistent_disks_prefix" {
  description = "Prefix of the name persistent disks for Vault to create. The prefix will be appended with the index"
  default     = "vault-data-"
}

variable "raft_disk_type" {
  description = "Raft data disk type"
  default     = "pd-ssd"
}

variable "raft_disk_size" {
  description = "Size of Raft disks in GB"
  default     = 100
}

variable "raft_disk_regional" {
  description = "Use regional disks instead of zonal disks"
  default     = true
}

variable "raft_disk_zones" {
  description = "List of zones for disks. If not set, will default to the zones in var.region"
  default     = []
  type        = list(string)
}

variable "raft_replica_zones" {
  description = "List of replica zones for disks. If not set, will default to the zones in var.region"
  default     = [[]]
  type        = list(list(string))
}

##################################
# Raft Data Disk Backup
##################################

variable "raft_backup_policy" {
  description = "Data disk backup policy name"
  default     = "vault-data-backup"
}

variable "raft_backup_max_retention_days" {
  description = "Maximum age of the snapshot that is allowed to be kept."
  default     = 14
}

variable "raft_snapshot_days_in_cycle" {
  description = "Number of days between snapshots"
  default     = 1
}

variable "raft_snapshot_start_time" {
  description = "Time in UTC format to start snapshot"
  default     = "19:00"
}

##################################
# GCS Storage
##################################
variable "gcs_storage_enable" {
  description = "Enable the use of GCS Storage"
  default     = false
}

variable "storage_bucket_name" {
  description = "Name of the Storage Bucket to store Vault's state"
  default     = ""
}

variable "storage_bucket_class" {
  description = "Storage class of the bucket. See https://cloud.google.com/storage/docs/storage-classes"
  default     = "REGIONAL"
}

variable "storage_bucket_location" {
  description = "Location of the storage bucket. Defaults to the provider's region if empty. This must be in the same location as your KMS key."
  default     = ""
}

variable "storage_bucket_project" {
  description = "Project ID to create the storage bucket under"
  default     = ""
}

variable "storage_bucket_labels" {
  description = "Set of labels for the storage bucket"

  default = {
    terraform = "true"
  }
}

variable "storage_ha_enabled" {
  description = "Use the GCS bucket to provide HA for Vault. Set to false if you are using alternative HA storage like Consul"
  default     = true
}

##################################
# KMS Configuration
##################################

variable "key_ring_name" {
  description = "Name of the Keyring to create."
  default     = "vault"
}

variable "kms_location" {
  description = "Location of the KMS key ring. Must be in the same location as your storage bucket"
}

variable "kms_project" {
  description = "Project ID to create the keyring in"
}

variable "unseal_key_name" {
  description = "Name of the Vault unseal key"
  default     = "unseal"
}

variable "unseal_key_rotation_period" {
  description = "Rotation period of the Vault unseal key. Defaults to 6 months"
  default     = "7776000s"
}

variable "storage_key_name" {
  description = "Name of the Vault storage key"
  default     = "storage"
}

variable "storage_key_rotation_period" {
  description = "Rotation period of the Vault storage key. Defaults to 90 days"
  default     = "7776000s"
}

##################################
# Optional GKE Node pool
##################################
variable "gke_pool_create" {
  description = "Whether to create the GKE node pool or not"
  default     = false
}

variable "vault_server_service_account" {
  description = "Service Account name for the Vault Server"
  default     = "vault-server"
}

variable "gke_pool_name" {
  description = "Name of the GKE Pool name to create"
  default     = "vault"
}

variable "gke_pool_location" {
  description = "Location for the node pool"
  default     = "<REQUIRED if gke_pool_create is true>"
}

variable "gke_cluster" {
  description = "Cluster to create node pool for"
  default     = "<REQUIRED if gke_pool_create is true>"
}

variable "gke_node_count" {
  description = "Initial Node count. If regional, remember to divide the desired node count by the number of zones"
  default     = 3
}

variable "gke_node_size_gb" {
  description = "Disk size for the nodes in GB"
  default     = "20"
}

variable "gke_disk_type" {
  description = "Disk type for the nodes"
  default     = "pd-standard"
}

variable "gke_machine_type" {
  description = "Machine type for the GKE nodes. Make sure this matches the resources you are requesting"
  default     = "n1-standard-2"
}

variable "gke_labels" {
  description = "Labels for the GKE nodes"
  default     = {}
}

variable "gke_metadata" {
  description = "Metadata for the GKE nodes"
  default     = {}
}

variable "gke_tags" {
  description = "Network tags for the GKE nodes"
  default     = []
}

variable "gke_taints" {
  description = "List of map of taints for GKE nodes. It is highly recommended you do set this alongside the pods toleration. See https://www.terraform.io/docs/providers/google/r/container_cluster.html#key for the keys and the README for more information"
  default     = []
}

variable "gke_node_upgrade_settings_enabled" {
  description = "Enable/disable gke node pool surge upgrade settings"
  default     = false
}

variable "gke_node_upgrade_settings" {
  description = "Surge upgrade settings as per https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-upgrades#surge"
  type        = object({ max_surge = number, max_unavailable = number })
  default = {
    max_surge       = 1
    max_unavailable = 0
  }
}

variable "vault_service_account" {
  description = "Required if you did not create a node pool. This should be the service account that is used by the nodes to run Vault workload. They will be given additional permissions to use the keys for auto unseal and to write to the storage bucket"
  default     = "<REQUIRED if not creating GKE node pool>"
}

variable "workload_identity_enable" {
  description = "Enable Workload Identity on the GKE Node Pool. For more information, see https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity"
  default     = false
}

variable "vault_node_service_account" {
  description = "Service Account for Vault Node Pools if Workload Identity is enabled"
  default     = "vault-gke-node"
}

variable "workload_identity_project" {
  description = "Project to Create the Service Accoutn for Vault Pods  if Workload Identity is enabled. Defaults to the GKE project."
  default     = ""
}

variable "vault_server_location_description" {
  description = "Location of Vault server to put in description strings of resources"
  default     = ""
}
