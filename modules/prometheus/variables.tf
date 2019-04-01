variable "release_name" {
  description = "Helm release name for Consul"
  default     = "prometheus"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "prometheus"
}

variable "chart_repository" {
  description = "Helm repository for the chart"
  default     = "stable"
}

variable "chart_version" {
  description = "Version of Chart to install. Set to empty to install the latest version"
  default     = ""
}

variable "chart_namespace" {
  description = "Namespace to install the chart into"
  default     = "default"
}

variable "image_pull_secrets" {
  description = "Image pull secrets, if any"
  default     = {}
}

################################
# Alertmanager
################################
variable "alertmanager_enable" {
  description = "Enable Alert manager"
  default     = "true"
}

variable "alertmanager_repository" {
  description = "Docker repository for Alert Manager"
  default     = "prom/alertmanager"
}

variable "alertmanager_tag" {
  description = "Tag for Alertmanager Docker Image"
  default     = "v0.16.1"
}

variable "alertmanager_pull_policy" {
  description = "Image pull policy for Alertmanager"
  default     = "IfNotPresent"
}

variable "alertmanager_priority_class_name" {
  description = "Priority Class Name for Alertmanager pods"
  default     = ""
}

variable "alertmanager_extra_args" {
  description = "Extra arguments for Alertmanager container"
  default     = {}
}

variable "alertmanager_extra_env" {
  description = "Extra environment variables for Alertmanager container"
  default     = {}
}

variable "prefix_url" {
  description = "The URL prefix at which the container can be accessed. Useful in the case the '-web.external-url' includes a slug so that the various internal URLs are still able to access as they are in the default case."
  default     = ""
}

variable "base_url" {
  description = "External URL which can access alertmanager"
  default     = "/"
}

variable "alertmanager_config_map_override_name" {
  description = "ConfigMap override where fullname is {{.Release.Name}}-{{.Values.alertmanager.configMapOverrideName} Defining configMapOverrideName will cause templates/alertmanager-configmap.yaml to NOT generate a ConfigMap resource"
  default     = ""
}

variable "alertmanager_config_from_secret" {
  description = "The name of a secret in the same kubernetes namespace which contains the Alertmanager config Defining configFromSecret will cause templates/alertmanager-configmap.yaml to NOT generate a ConfigMap resource"
  default     = ""
}

variable "alertmanager_config_file_name" {
  description = "The configuration file name to be loaded to alertmanager Must match the key within configuration loaded from ConfigMap/Secret"
  default     = "alertmanager.yml"
}

variable "alertmanager_ingress_enabled" {
  description = "Enable ingress for Alertmanager"
  default     = "false"
}

variable "alertmanager_ingress_annotations" {
  description = "Annotations for Alertmanager ingress"
  default     = {}
}

variable "alertmanager_ingress_extra_labels" {
  description = "Additional labels for Alertmanager ingress"
  default     = {}
}

variable "alertmanager_ingress_hosts" {
  description = "List of Hosts for Alertmanager ingress"
  default     = []
}

variable "alertmanager_ingress_tls" {
  description = "TLS configurationf or Alertmanager ingress"
  default     = []
}

variable "alertmanager_annotations" {
  description = "Annotations for Alertmanager pods"
  default     = {}
}

variable "alertmanager_tolerations" {
  description = "Tolerations for Alertmanager"
  default     = []
}

variable "alertmanager_node_selector" {
  description = "Node selector for alertmanager pods"
  default     = {}
}

variable "alertmanager_affinity" {
  description = "Affinity for alertmanager pods"
  default     = {}
}

variable "alertmanager_pv_enabled" {
  description = "Enable persistent volume on Alertmanager"
  default     = "true"
}

variable "alertmanager_pv_access_modes" {
  description = "alertmanager data Persistent Volume access modes"

  default = [
    "ReadWriteOnce",
  ]
}

variable "alertmanager_pv_annotations" {
  description = "Annotations for Alertmanager PV"
  default     = {}
}

variable "alertmanager_pv_existing_claim" {
  description = "Use an existing PV claim for alertmanager"
  default     = ""
}

variable "alertmanager_pv_size" {
  description = "alertmanager data Persistent Volume size"
  default     = "2Gi"
}

variable "alertmanager_replica" {
  description = "Number of replicas for AlertManager"
  default     = 1
}

variable "alertmanager_headless_annotations" {
  description = "Annotations for alertmanager StatefulSet headless service"
  default     = {}
}

variable "alertmanager_headless_labels" {
  description = "Labels for alertmanager StatefulSet headless service"
  default     = {}
}

variable "alertmanager_resources" {
  description = "Resources for alertmanager"
  default     = {}
}

variable "alertmanger_security_context" {
  description = "Security context for alertmanager pods"
  default     = {}
}

variable "alertmanager_service_annotations" {
  description = "Annotations for Alertmanager service"
  default     = {}
}

variable "alertmanager_service_labels" {
  description = "Labels for Alertmanager service"
  default     = {}
}

variable "alertmanager_service_cluster_ip" {
  description = "Cluster IP for Alertmanager Service"
  default     = ""
}

variable "alertmanager_service_external_ips" {
  description = "External IPs for Alertmanager service"
  default     = []
}

variable "alertmanager_service_lb_ip" {
  description = "Load Balancer IP for Alertmanager service"
  default     = ""
}

variable "alertmanager_service_lb_source_ranges" {
  description = "List of source CIDRs allowed to access the Alertmanager LB"
  default     = []
}

variable "alertmanager_service_port" {
  description = "Service port for Alertmanager"
  default     = 80
}

variable "alertmanager_service_type" {
  description = "Type of service for Alertmanager"
  default     = "ClusterIP"
}
