variable "external_static_ip_name" {
  description = "Name of the Static IP resource to deploy for the external (internet) facing Network LB"
}

variable "internal_static_ip_name" {
  description = "Name of the Static IP resource to deploy for the internal (intranet) facing Network LB. Set to an empty string to disable."
  default     = ""
}

variable "internal_static_ip_subnetwork" {
  description = "The URL of the subnetwork in which to reserve the internal static address"
}

variable "release_name" {
  description = "Helm release name for Traefik"
  default     = "traefik"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "stable/traefik"
}

variable "chart_repository" {
  description = "Helm repository for the chart"
  default     = ""
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version"
  default     = "1.59.2"
}

variable "traefik_image_name" {
  description = "Docker Image of Traefik to run"
  default     = "traefik"
}

variable "traefik_image_tag" {
  description = "Docker image tag of Traefik to run"
  default     = "1.7-alpine"
}

variable "service_type" {
  description = "Kubernetes service type to run as. `NodePort` or `LoadBalancer`."
  default     = "LoadBalancer"
}

variable "external_cidr" {
  description = "List of CIDR allowed to access the external endpoint"
  default     = ["0.0.0.0/0"]
}

variable "external_traffic_policy" {
  description = "Route traffic to Traefik using node-local or cluster-wide endpoints. See https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip"
  default     = "Cluster"
}

variable "replicas" {
  description = "Number of replias to run"
  default     = 1
}

variable "cpu_request" {
  description = "Initial share of CPU requested per Traefik pod"
  default     = "100m"
}

variable "memory_request" {
  description = "Initial share of memory requested per Traefik pod"
  default     = "20Mi"
}

variable "cpu_limit" {
  description = "CPU limit per Traefik pod"
  default     = "100m"
}

variable "memory_limit" {
  description = "Memory limit per Traefik pod"
  default     = "30Mi"
}

variable "node_selector" {
  description = "Node labels for pod assignment"
  default     = {}
}

variable "affinity" {
  description = "Affinity settings"
}

variable "service_annotations" {
  description = "Annotations for the Traefik Service definition, specified as a map"
  default     = {}
}

variable "service_labels" {
  description = "Additional labels for the Traefik Service definition, specified as a map."
  default     = {}
}

variable "pod_annotations" {
  description = "Annotations for the Traefik pod definition"
  default     = {}
}

variable "pod_labels" {
  description = "Labels for the Traefik pod definition"
  default     = {}
}

variable "rbac_enabled" {
  description = "Whether to enable RBAC with a specific cluster role and binding for Traefik"
  default     = "true"
}
