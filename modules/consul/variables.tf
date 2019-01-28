variable "release_name" {
  description = "Helm release name for Consul"
  default     = "consul"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "https://github.com/basisai/consul-helm/archive/extensions.tar.gz"
}

variable "chart_repository" {
  description = "Helm repository for the chart"
  default     = ""
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version"
  default     = ""
}

variable "chart_namespace" {
  description = "Namespace to install the chart into"
  default     = "default"
}

variable "consul_image_name" {
  description = "Docker Image of Consul to run"
  default     = "consul"
}

variable "consul_image_tag" {
  description = "Docker image tag of Consul to run"
  default     = "1.4.1"
}

variable "consul_k8s_image" {
  description = "Docker image of the consul-k8s binary to run"
  default     = "hashicorp/consul-k8s"
}

variable "consul_k8s_tag" {
  description = "Image tag of the consul-k8s binary to run"
  default     = "0.4.0"
}

variable "consul_domain" {
  description = "Top level Consul domain for DNS queries"
  default     = "consul"
}

variable "server_replicas" {
  description = "Number of server replicas to run"
  default     = 5
}

variable "server_storage" {
  description = "This defines the disk size for configuring the servers' StatefulSet storage. For dynamically provisioned storage classes, this is the desired size. For manually defined persistent volumes, this should be set to the disk size of the attached volume."
  default     = "10Gi"
}

variable "server_storage_class" {
  description = "The StorageClass to use for the servers' StatefulSet storage. It must be able to be dynamically provisioned if you want the storage to be automatically created. For example, to use Local storage classes, the PersistentVolumeClaims would need to be manually created. An empty value will use the Kubernetes cluster's default StorageClass."
  default     = ""
}

variable "server_cpu_request" {
  description = "CPU request for server pods"
  default     = "500m"
}

variable "server_memory_request" {
  description = "Memory request for server pods"
  default     = "2Gi"
}

variable "server_cpu_limit" {
  description = "CPU limit for server pods"
  default     = "2000m"
}

variable "server_memory_limit" {
  description = "Memory limit for server pods"
  default     = "4Gi"
}

variable "server_extra_config" {
  description = "Raw string of additional configuration to include for servers in JSON/HCL"
  default     = "{}"
}

variable "server_extra_volumes" {
  description = "List of map of extra volumes specification for server pods. See https://www.consul.io/docs/platform/k8s/helm.html#v-server-extravolumes for the keys"
  default     = []
}

variable "client_enabled" {
  description = "Enable running Consul client agents on every Kubernetes node"
  default     = "true"
}

variable "client_cpu_request" {
  description = "CPU request for client agent pods"
  default     = "250m"
}

variable "client_memory_request" {
  description = "Memory request for client agent pods"
  default     = "1Gi"
}

variable "client_cpu_limit" {
  description = "CPU limit for client agent pods"
  default     = "1000m"
}

variable "client_memory_limit" {
  description = "Memory limit for client agent pods"
  default     = "2Gi"
}

variable "client_extra_config" {
  description = "Raw string of additional configuration to include for client agents in JSON/HCL"
  default     = "{}"
}

variable "client_extra_volumes" {
  description = "List of map of extra volumes specification. See https://www.consul.io/docs/platform/k8s/helm.html#v-client-extravolumes for the keys"
  default     = []
}

variable "enable_sync_catalog" {
  description = "Enable Service catalog sync: https://www.consul.io/docs/platform/k8s/service-sync.html"
  default     = "true"
}

variable "sync_by_default" {
  description = "If true, all valid services in K8S are synced by default. If false, the service must be annotated properly to sync. In either case an annotation can override the default."
  default     = "true"
}

variable "sync_to_consul" {
  description = "If true, will sync Kubernetes services to Consul. This can be disabled to have a one-way sync."
  default     = "true"
}

variable "sync_to_k8s" {
  description = " If true, will sync Consul services to Kubernetes. This can be disabled to have a one-way sync."
  default     = "true"
}

variable "sync_k8s_prefix" {
  description = " A prefix to prepend to all services registered in Kubernetes from Consul. This defaults to '' where no prefix is prepended; Consul services are synced with the same name to Kubernetes. (Consul -> Kubernetes sync only)"
  default     = ""
}

variable "sync_k8s_tag" {
  description = "An optional tag that is applied to all of the Kubernetes services that are synced into Consul. If nothing is set, this defaults to 'k8s'. (Kubernetes -> Consul sync only)"
  default     = "k8s"
}

variable "sync_cluster_ip_services" {
  description = "If true, will sync Kubernetes ClusterIP services to Consul. This can be disabled to have the sync ignore ClusterIP-type services."
  default     = "true"
}

variable "sync_node_port_type" {
  description = "Configures the type of syncing that happens for NodePort services. The only valid options are: ExternalOnly, InternalOnly, and ExternalFirst. ExternalOnly will only use a node's ExternalIP address for the sync, otherwise the service will not be synced. InternalOnly uses the node's InternalIP address. ExternalFirst will preferentially use the node's ExternalIP address, but if it doesn't exist, it will use the node's InternalIP address instead."
  default     = ""
}

variable "enable_ui" {
  description = "Enable Consul UI"
  default     = "false"
}

variable "ui_service_type" {
  description = "Type of service for Consul UI"
  default     = "ClusterIP"
}

variable "ui_annotations" {
  description = "UI service annotations"
  default     = ""
}

variable "ui_additional_spec" {
  description = "Additional Spec for the UI service"
  default     = ""
}

variable "enable_connect_inject" {
  description = "Enable Connect Injector process"
  default     = "false"
}

variable "connect_inject_by_default" {
  description = "If true, the injector will inject the Connect sidecar into all pods by default. Otherwise, pods must specify the injection annotation to opt-in to Connect injection. If this is true, pods can use the same annotation to explicitly opt-out of injection."
  default     = "false"
}

variable "connect_inject_namespace_selector" {
  description = "A selector for restricting injection to only matching namespaces. By default all namespaces except the system namespace will have injection enabled."
  default     = ""
}

variable "configure_kube_dns" {
  description = "Configure kube-dns and OVERWRITE it to resolve .consul domains with Consul DNS"
  default     = false
}
