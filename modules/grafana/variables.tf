variable "release_name" {
  description = "Helm release name for Grafana"
  default     = "grafana"
}

variable "chart_name" {
  description = "Helm chart name to provision"
  default     = "grafana"
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

variable "service_account" {
  description = "Name of the Service Account for Grafana"
  default     = ""
}

variable "replicas" {
  description = "Number of replicas of Grafana to run"
  default     = 1
}

variable "image" {
  description = "Docker Image for Grafana"
  default     = "grafana/grafana"
}

variable "tag" {
  description = "Docker Image tag for Grafana"
  default     = "6.0.2"
}

variable "image_pull_policy" {
  description = "Image Pull Policy for Grafana"
  default     = "IfNotPresent"
}

variable "run_as_user" {
  description = "UID to run the Grafana container in"
  default     = "472"
}

variable "fs_group" {
  description = "GID for the File system group for the Grafana container"
  default     = "472"
}

variable "extra_configmap_mounts" {
  description = "Extra ConfigMap to mount into the Container"
  default     = []
}

variable "extra_empty_dir_mounts" {
  description = "Extra Empty DIRs to mount into the Container"
  default     = []
}

variable "priority_class_name" {
  description = "Priority Class name for Grafana"
  default     = ""
}

variable "pod_annotations" {
  description = "Pod annotations"
  default     = {}
}

variable "annotations" {
  description = "Deployment annotations"
  default     = {}
}

variable "service_type" {
  description = "Service type"
  default     = "ClusterIP"
}

variable "service_port" {
  description = "Port of the service"
  default     = "80"
}

variable "service_target_port" {
  description = "Port in container to expose service"
  default     = "3000"
}

variable "service_annotations" {
  description = "Annotations for the service"
  default     = {}
}

variable "service_labels" {
  description = "Labels for the service"
  default     = {}
}

variable "ingress_enabled" {
  description = "Enable Ingress"
  default     = "false"
}

variable "ingress_annotations" {
  description = "Annotations for ingress"
  default     = {}
}

variable "ingress_labels" {
  description = "Labels for ingress"
  default     = {}
}

variable "ingress_hosts" {
  description = "Hosts for ingress"
  default     = []
}

variable "ingress_tls" {
  description = "TLS configuration for ingress"
  default     = []
}

variable "resources" {
  description = "Resources for Grafana container"
  default     = {}
}

variable "node_selector" {
  description = "Node selector for Pods"
  default     = {}
}

variable "tolerations" {
  description = "Tolerations for pods"
  default     = []
}

variable "affinity" {
  description = "Pod affinity"
  default     = {}
}

variable "extra_init_containers" {
  description = "Extra init containers"
  default     = []
}

variable "extra_containers" {
  description = "YAML string for extra containers"
  default     = ""
}

variable "persistence_enabled" {
  description = "Enable PV"
  default     = "false"
}

variable "persistence_storage_class_name" {
  description = "Storage Class name for the PV"
  default     = "default"
}

variable "persistence_annotations" {
  description = "Annotations for the PV"
  default     = {}
}

variable "persistence_size" {
  description = "Size of the PV"
  default     = "10Gi"
}

variable "persistence_existing_claim" {
  description = "Use an existing PVC"
  default     = ""
}

variable "init_chown_data_enabled" {
  description = "Enable the Chown init container"
  default     = "true"
}

variable "init_chown_data_resources" {
  description = "Resources for the Chown init container"
  default     = {}
}

variable "env" {
  description = "Extra environment variables that will be pass onto deployment pods"
  default     = {}
}

variable "env_from_secret" {
  description = "The name of a secret in the same kubernetes namespace which contain values to be added to the environment"
  default     = ""
}

variable "extra_secret_mounts" {
  description = "Additional grafana server secret mounts"
  default     = []
}

variable "extra_volume_mounts" {
  description = "Additional grafana server volume mounts"
  default     = []
}

variable "command" {
  description = "Define command to be executed at startup by grafana container"
  default     = []
}

variable "plugins" {
  description = "List of plugins to install"
  default     = []
}

variable "datasources" {
  description = "YAML string to configure grafana datasources http://docs.grafana.org/administration/provisioning/#datasources"
  default     = ""
}

variable "notifiers" {
  description = "YAML string to configure notifiers http://docs.grafana.org/administration/provisioning/#alert-notification-channels"
  default     = ""
}

variable "dashboard_providers" {
  description = "YAML string to configure grafana dashboard providersref: http://docs.grafana.org/administration/provisioning/#dashboards `path` must be /var/lib/grafana/dashboards/<provider_name>"
  default     = ""
}

variable "dashboards" {
  description = "YAML string to configure grafana dashboard to import"
  default     = ""
}

variable "dashboards_config_maps" {
  description = "Reference to external ConfigMap per provider. Use provider name as key and ConfiMap name as value. YAML string"
  default     = ""
}

variable "main_config" {
  description = "Main Config file in YAML"

  default = <<EOF
paths:
  data: /var/lib/grafana/data
  logs: /var/log/grafana
  plugins: /var/lib/grafana/plugins
  provisioning: /etc/grafana/provisioning
analytics:
  check_for_updates: true
log:
  mode: console
grafana_net:
  url: https://grafana.net
EOF
}

variable "ldap_existing_secret" {
  description = "Use an existing secret for LDAP config"
  default     = ""
}

variable "ldap_config" {
  description = "String with contents for LDAP configuration in TOML"
  default     = ""
}

variable "smtp_existing_secret" {
  description = "Existing secret containing the SMTP credentials"
  default     = ""
}

variable "smtp_user_key" {
  description = "Key in the secret containing the SMTP username"
  default     = "user"
}

variable "smtp_password_key" {
  description = "Key in the secret containing the SMTP password"
  default     = "password"
}
