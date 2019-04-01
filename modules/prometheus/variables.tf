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

variable "extra_scrape_configs" {
  description = "YAML String for extra scrape configs"
  default     = ""
}

variable "enable_network_policy" {
  description = "Create a NetworkPolicy resource"
  default     = "false"
}

################################
# ConfigMap Reload
################################
variable "configmap_name" {
  description = "Name of the ConfigMap Reload container"
  default     = "configmap-reload"
}

variable "configmap_image_repo" {
  description = "Docker Image repo for ConfigMap Reload"
  default     = "jimmidyson/configmap-reload"
}

variable "configmap_image_tag" {
  description = "Docker image tag for ConfigMap Reload"
  default     = "v0.2.2"
}

variable "configmap_pull_policy" {
  description = "Image pull policy for ConfigMap reload"
  default     = "IfNotPresent"
}

variable "configmap_extra_args" {
  description = "Extra arguments for ConfigMap Reload"
  default     = {}
}

variable "configmap_extra_volumes" {
  description = "Extra volumes for ConfigMap Extra Volumes"
  default     = []
}

variable "configmap_resources" {
  description = "Resources for ConfigMap Reload pod"
  default     = {}
}

################################
# initChownData
################################
variable "init_chown_enabled" {
  description = "Enable initChownData"
  default     = "true"
}

variable "init_chown_name" {
  description = "NAme of the initChownData container"
  default     = "init-chown-data"
}

variable "init_chown_image_repo" {
  description = "Docker Image repo for initChownData"
  default     = "busybox"
}

variable "init_chown_image_tag" {
  description = "Docker image tag for initChownData"
  default     = "latest"
}

variable "init_chown_pull_policy" {
  description = "Image pull policy for initChownData"
  default     = "IfNotPresent"
}

variable "init_chown_resources" {
  description = "Resources for initChownData"
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

variable "alertmanager_files" {
  description = "Additional ConfigMap entries for Alertmanager"

  default {
    "alertmanager.yml" = {
      global = {}

      receivers = [
        {
          name = "default-receiver"
        },
      ]

      route = {
        group_wait      = "10s"
        group_interval  = "5m"
        receiver        = "default-receiver"
        repeat_interval = "3h"
      }
    }
  }
}

################################
# Kube State Metrics
################################
variable "kube_state_metrics_enable" {
  description = "Enable Kube State Metrics"
  default     = "true"
}

variable "kube_state_metrics_repository" {
  description = "Docker repository for Kube State Metrics"
  default     = "quay.io/coreos/kube-state-metrics"
}

variable "kube_state_metrics_tag" {
  description = "Tag for Kube State Metrics Docker Image"
  default     = "v1.5.0"
}

variable "kube_state_metrics_pull_policy" {
  description = "Image pull policy for Kube State Metrics"
  default     = "IfNotPresent"
}

variable "kube_state_metrics_priority_class_name" {
  description = "Priority Class Name for Kube State Metrics pods"
  default     = ""
}

variable "kube_state_metrics_extra_args" {
  description = "Extra arguments for Kube State Metrics container"
  default     = {}
}

variable "kube_state_metrics_extra_env" {
  description = "Extra environment variables for Kube State Metrics container"
  default     = {}
}

variable "kube_state_metrics_annotations" {
  description = "Annotations for Kube State Metrics pods"
  default     = {}
}

variable "kube_state_metrics_tolerations" {
  description = "Tolerations for Kube State Metrics"
  default     = []
}

variable "kube_state_metrics_labels" {
  description = "Labels for Kube State Metrics"
  default     = {}
}

variable "kube_state_metrics_node_selector" {
  description = "Node selector for kube_state_metrics pods"
  default     = {}
}

variable "kube_state_metrics_replica" {
  description = "Number of replicas for AlertManager"
  default     = 1
}

variable "kube_state_metrics_resources" {
  description = "Resources for kube_state_metrics"
  default     = {}
}

variable "kube_state_metrics_security_context" {
  description = "Security context for kube_state_metrics pods"
  default     = {}
}

variable "kube_state_metrics_service_annotations" {
  description = "Annotations for Kube State Metrics service"

  default = {
    "prometheus.io/scrape" = "true"
  }
}

variable "kube_state_metrics_service_labels" {
  description = "Labels for Kube State Metrics service"
  default     = {}
}

variable "kube_state_metrics_service_cluster_ip" {
  description = "Cluster IP for Kube State Metrics Service"
  default     = "None"
}

variable "kube_state_metrics_service_external_ips" {
  description = "External IPs for Kube State Metrics service"
  default     = []
}

variable "kube_state_metrics_service_lb_ip" {
  description = "Load Balancer IP for Kube State Metrics service"
  default     = ""
}

variable "kube_state_metrics_service_lb_source_ranges" {
  description = "List of source CIDRs allowed to access the Kube State Metrics LB"
  default     = []
}

variable "kube_state_metrics_service_port" {
  description = "Service port for Kube State Metrics"
  default     = 80
}

variable "kube_state_metrics_service_type" {
  description = "Type of service for Kube State Metrics"
  default     = "ClusterIP"
}

################################
# Node Exporter
################################
variable "node_exporter_enable" {
  description = "Enable Node Exporter"
  default     = "true"
}

variable "node_exporter_host_network" {
  description = "Use the Host network namespace for Node Exporter"
  default     = "true"
}

variable "node_exporter_host_pid" {
  description = "Use the Network PID namespace for Node Exporter"
  default     = "true"
}

variable "node_exporter_repository" {
  description = "Docker repository for Node Exporter"
  default     = "prom/node-exporter"
}

variable "node_exporter_tag" {
  description = "Tag for Node Exporter Docker Image"
  default     = "v0.17.0"
}

variable "node_exporter_pull_policy" {
  description = "Image pull policy for Node Exporter"
  default     = "IfNotPresent"
}

variable "node_exporter_enable_pod_security_policy" {
  description = "Create PodSecurityPolicy for Node Exporter"
  default     = "false"
}

variable "node_exporter_pod_security_policy_annotations" {
  description = "Annotations for the PodSecurityPolicy for Node Exporter"
  default     = {}
}

variable "node_exporter_priority_class_name" {
  description = "Priority Class Name for Node Exporter pods"
  default     = ""
}

variable "node_exporter_extra_args" {
  description = "Extra arguments for Node Exporter container"
  default     = {}
}

variable "node_exporter_extra_env" {
  description = "Extra environment variables for Node Exporter container"
  default     = {}
}

variable "node_exporter_annotations" {
  description = "Annotations for Node Exporter pods"
  default     = {}
}

variable "node_exporter_tolerations" {
  description = "Tolerations for Node Exporter"
  default     = []
}

variable "node_exporter_labels" {
  description = "Labels for Node Exporter"
  default     = {}
}

variable "node_exporter_node_selector" {
  description = "Node selector for node_exporter pods"
  default     = {}
}

variable "node_exporter_replica" {
  description = "Number of replicas for AlertManager"
  default     = 1
}

variable "node_exporter_resources" {
  description = "Resources for node_exporter"
  default     = {}
}

variable "node_exporter_security_context" {
  description = "Security context for node_exporter pods"
  default     = {}
}

variable "node_exporter_service_annotations" {
  description = "Annotations for Node Exporter service"

  default = {
    "prometheus.io/scrape" = "true"
  }
}

variable "node_exporter_service_labels" {
  description = "Labels for Node Exporter service"
  default     = {}
}

variable "node_exporter_service_cluster_ip" {
  description = "Cluster IP for Node Exporter Service"
  default     = "None"
}

variable "node_exporter_service_external_ips" {
  description = "External IPs for Node Exporter service"
  default     = []
}

variable "node_exporter_service_lb_ip" {
  description = "Load Balancer IP for Node Exporter service"
  default     = ""
}

variable "node_exporter_service_lb_source_ranges" {
  description = "List of source CIDRs allowed to access the Node Exporter LB"
  default     = []
}

variable "node_exporter_service_port" {
  description = "Service port for Node Exporter"
  default     = 9100
}

variable "node_exporter_service_type" {
  description = "Type of service for Node Exporter"
  default     = "ClusterIP"
}

variable "node_exporter_host_path_mounts" {
  description = "Host Path Mounts for Node Exporter"
  default     = []
}

variable "node_exporter_config_map_mounts" {
  description = "ConfigMap Mounts for Node Exporter"
  default     = []
}
