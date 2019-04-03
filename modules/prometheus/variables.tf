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

variable "alertmanager_prefix_url" {
  description = "The URL prefix at which the container can be accessed. Useful in the case the '-web.external-url' includes a slug so that the various internal URLs are still able to access as they are in the default case."
  default     = ""
}

variable "alertmanager_base_url" {
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

variable "alertmanager_security_context" {
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
  description = "Additional ConfigMap entries for Alertmanager in YAML string"

  default = <<EOF
alertmanager.yml:
  global: {}
    # slack_api_url: ''

  receivers:
    - name: default-receiver
      # slack_configs:
      #  - channel: '@you'
      #    send_resolved: true

  route:
    group_wait: 10s
    group_interval: 5m
    receiver: default-receiver
    repeat_interval: 3h
EOF
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
  description = "Node selector for Kube State Metrics pods"
  default     = {}
}

variable "kube_state_metrics_replica" {
  description = "Number of replicas for Kube State Metrics"
  default     = 1
}

variable "kube_state_metrics_resources" {
  description = "Resources for Kube State Metrics"
  default     = {}
}

variable "kube_state_metrics_security_context" {
  description = "Security context for Kube State Metrics pods"
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
  description = "Number of replicas for Node Exporter"
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

################################
# Pushgateway
################################
variable "pushgateway_enable" {
  description = "Enable Pushgateway"
  default     = "true"
}

variable "pushgateway_repository" {
  description = "Docker repository for Pushgateway"
  default     = "prom/pushgateway"
}

variable "pushgateway_tag" {
  description = "Tag for Pushgateway Docker Image"
  default     = "v0.6.0"
}

variable "pushgateway_pull_policy" {
  description = "Image pull policy for Pushgateway"
  default     = "IfNotPresent"
}

variable "pushgateway_priority_class_name" {
  description = "Priority Class Name for Pushgateway pods"
  default     = ""
}

variable "pushgateway_extra_args" {
  description = "Extra arguments for Pushgateway container"
  default     = {}
}

variable "pushgateway_extra_env" {
  description = "Extra environment variables for Pushgateway container"
  default     = {}
}

variable "pushgateway_ingress_enabled" {
  description = "Enable ingress for Pushgateway"
  default     = "false"
}

variable "pushgateway_ingress_annotations" {
  description = "Annotations for Pushgateway ingress"
  default     = {}
}

variable "pushgateway_ingress_extra_labels" {
  description = "Additional labels for Pushgateway ingress"
  default     = {}
}

variable "pushgateway_ingress_hosts" {
  description = "List of Hosts for Pushgateway ingress"
  default     = []
}

variable "pushgateway_ingress_tls" {
  description = "TLS configurationf or Pushgateway ingress"
  default     = []
}

variable "pushgateway_annotations" {
  description = "Annotations for Pushgateway pods"
  default     = {}
}

variable "pushgateway_tolerations" {
  description = "Tolerations for Pushgateway"
  default     = []
}

variable "pushgateway_node_selector" {
  description = "Node selector for pushgateway pods"
  default     = {}
}

variable "pushgateway_pv_enabled" {
  description = "Enable persistent volume on Pushgateway"
  default     = "true"
}

variable "pushgateway_pv_access_modes" {
  description = "pushgateway data Persistent Volume access modes"

  default = [
    "ReadWriteOnce",
  ]
}

variable "pushgateway_pv_annotations" {
  description = "Annotations for Pushgateway PV"
  default     = {}
}

variable "pushgateway_pv_existing_claim" {
  description = "Use an existing PV claim for pushgateway"
  default     = ""
}

variable "pushgateway_pv_size" {
  description = "pushgateway data Persistent Volume size"
  default     = "2Gi"
}

variable "pushgateway_replica" {
  description = "Number of replicas for pushgateway"
  default     = 1
}

variable "pushgateway_resources" {
  description = "Resources for pushgateway"
  default     = {}
}

variable "pushgateway_security_context" {
  description = "Security context for pushgateway pods"
  default     = {}
}

variable "pushgateway_service_annotations" {
  description = "Annotations for Pushgateway service"

  default = {
    "prometheus.io/probe" = "pushgateway"
  }
}

variable "pushgateway_service_labels" {
  description = "Labels for Pushgateway service"
  default     = {}
}

variable "pushgateway_service_cluster_ip" {
  description = "Cluster IP for Pushgateway Service"
  default     = ""
}

variable "pushgateway_service_external_ips" {
  description = "External IPs for Pushgateway service"
  default     = []
}

variable "pushgateway_service_lb_ip" {
  description = "Load Balancer IP for Pushgateway service"
  default     = ""
}

variable "pushgateway_service_lb_source_ranges" {
  description = "List of source CIDRs allowed to access the Pushgateway LB"
  default     = []
}

variable "pushgateway_service_port" {
  description = "Service port for Pushgateway"
  default     = 9091
}

variable "pushgateway_service_type" {
  description = "Type of service for Pushgateway"
  default     = "ClusterIP"
}

################################
# Server
################################
variable "server_repository" {
  description = "Docker repository for server"
  default     = "prom/prometheus"
}

variable "server_tag" {
  description = "Tag for server Docker Image"
  default     = "v2.8.0"
}

variable "server_pull_policy" {
  description = "Image pull policy for server"
  default     = "IfNotPresent"
}

variable "server_sidecar_containers" {
  description = "Sidecar containers for server"
  default     = []
}

variable "server_priority_class_name" {
  description = "Priority Class Name for server pods"
  default     = ""
}

variable "server_extra_args" {
  description = "Extra arguments for server container"
  default     = {}
}

variable "server_extra_env" {
  description = "Extra environment variables for server container"
  default     = {}
}

variable "server_ingress_enabled" {
  description = "Enable ingress for server"
  default     = "false"
}

variable "server_ingress_annotations" {
  description = "Annotations for server ingress"
  default     = {}
}

variable "server_ingress_extra_labels" {
  description = "Additional labels for server ingress"
  default     = {}
}

variable "server_ingress_hosts" {
  description = "List of Hosts for server ingress"
  default     = []
}

variable "server_ingress_tls" {
  description = "TLS configurationf or server ingress"
  default     = []
}

variable "server_annotations" {
  description = "Annotations for server pods"
  default     = {}
}

variable "server_tolerations" {
  description = "Tolerations for server"
  default     = []
}

variable "server_node_selector" {
  description = "Node selector for server pods"
  default     = {}
}

variable "server_affinity" {
  description = "Affinity for server pods"
  default     = {}
}

variable "server_pv_enabled" {
  description = "Enable persistent volume on server"
  default     = "true"
}

variable "server_pv_access_modes" {
  description = "server data Persistent Volume access modes"

  default = [
    "ReadWriteOnce",
  ]
}

variable "server_pv_annotations" {
  description = "Annotations for server PV"
  default     = {}
}

variable "server_pv_existing_claim" {
  description = "Use an existing PV claim for server"
  default     = ""
}

variable "server_pv_size" {
  description = "server data Persistent Volume size"
  default     = "8Gi"
}

variable "server_replica" {
  description = "Number of replicas for server"
  default     = 1
}

variable "server_resources" {
  description = "Resources for server"
  default     = {}
}

variable "server_security_context" {
  description = "Security context for server pods"
  default     = {}
}

variable "server_service_annotations" {
  description = "Annotations for server service"

  default = {
    "prometheus.io/probe" = "server"
  }
}

variable "server_service_labels" {
  description = "Labels for server service"
  default     = {}
}

variable "server_service_cluster_ip" {
  description = "Cluster IP for server Service"
  default     = ""
}

variable "server_service_external_ips" {
  description = "External IPs for server service"
  default     = []
}

variable "server_service_lb_ip" {
  description = "Load Balancer IP for server service"
  default     = ""
}

variable "server_service_lb_source_ranges" {
  description = "List of source CIDRs allowed to access the server LB"
  default     = []
}

variable "server_service_port" {
  description = "Service port for server"
  default     = 9091
}

variable "server_service_type" {
  description = "Type of service for server"
  default     = "ClusterIP"
}

variable "server_prefix_url" {
  description = "The URL prefix at which the container can be accessed. Useful in the case the '-web.external-url' includes a slug so that the various internal URLs are still able to access as they are in the default case."
  default     = ""
}

variable "server_base_url" {
  description = "External URL which can access alertmanager"
  default     = ""
}

variable "server_enable_admin_api" {
  description = "Enable Admin API for server"
  default     = "false"
}

variable "server_skip_tsdb_lock" {
  description = "Disable TSDB locking for the server"
  default     = "false"
}

variable "server_scrape_interval" {
  description = "How frequently to scrape targets by default"
  default     = "1m"
}

variable "server_scrape_timeout" {
  description = "How long until a scrape request times out"
  default     = "10s"
}

variable "server_evaluation_interval" {
  description = "How frequently to evaluate rules"
  default     = "1m"
}

variable "server_extra_volume_mounts" {
  description = "Additional Prometheus server Volume mounts"
  default     = []
}

variable "server_extra_volumes" {
  description = "Additional Prometheus server Volumes"
  default     = []
}

variable "server_extra_host_path_mounts" {
  description = "Additional Prometheus server hostPath mounts"
  default     = []
}

variable "server_extra_configmap_mounts" {
  description = "Additional Prometheus server ConfigMap mounts"
  default     = []
}

variable "server_extra_secret_mounts" {
  description = "Extra secret mounts for server"
  default     = []
}

variable "server_statefulset_annotations" {
  description = "Annotations for server StatefulSet"
  default     = {}
}

variable "server_data_retention" {
  description = "Prometheus data retention period (i.e 360h)"
  default     = ""
}

variable "server_termination_grace_seconds" {
  description = "Prometheus server pod termination grace period"
  default     = "300"
}

variable "server_headless_annotations" {
  description = "Annotations for server StatefulSet headless service"
  default     = {}
}

variable "server_headless_labels" {
  description = "Labels for server StatefulSet headless service"
  default     = {}
}

variable "server_files" {
  description = "Prometheus server ConfigMap entries in YAML"

  default = <<EOF
## Alerts configuration
## Ref: https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/
alerts: {}
# groups:
#   - name: Instances
#     rules:
#       - alert: InstanceDown
#         expr: up == 0
#         for: 5m
#         labels:
#           severity: page
#         annotations:
#           description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 5 minutes.'
#           summary: 'Instance {{ $labels.instance }} down'

rules: {}

prometheus.yml:
  rule_files:
    - /etc/config/rules
    - /etc/config/alerts

  scrape_configs:
    - job_name: prometheus
      static_configs:
        - targets:
          - localhost:9090

    # A scrape configuration for running Prometheus on a Kubernetes cluster.
    # This uses separate scrape configs for cluster components (i.e. API server, node)
    # and services to allow each to use different authentication configs.
    #
    # Kubernetes labels will be added as Prometheus labels on metrics via the
    # `labelmap` relabeling action.

    # Scrape config for API servers.
    #
    # Kubernetes exposes API servers as endpoints to the default/kubernetes
    # service so this uses `endpoints` role and uses relabelling to only keep
    # the endpoints associated with the default/kubernetes service using the
    # default named port `https`. This works for single API server deployments as
    # well as HA API server deployments.
    - job_name: 'kubernetes-apiservers'

      kubernetes_sd_configs:
        - role: endpoints

      # Default to scraping over https. If required, just disable this or change to
      # `http`.
      scheme: https

      # This TLS & bearer token file config is used to connect to the actual scrape
      # endpoints for cluster components. This is separate to discovery auth
      # configuration because discovery & scraping are two separate concerns in
      # Prometheus. The discovery auth config is automatic if Prometheus runs inside
      # the cluster. Otherwise, more config options have to be provided within the
      # <kubernetes_sd_config>.
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        # If your node certificates are self-signed or use a different CA to the
        # master CA, then disable certificate verification below. Note that
        # certificate verification is an integral part of a secure infrastructure
        # so this should only be disabled in a controlled environment. You can
        # disable certificate verification by uncommenting the line below.
        #
        insecure_skip_verify: true
      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token

      # Keep only the default/kubernetes service endpoints for the https port. This
      # will add targets for each API server which Kubernetes adds an endpoint to
      # the default/kubernetes service.
      relabel_configs:
        - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]
          action: keep
          regex: default;kubernetes;https

    - job_name: 'kubernetes-nodes'

      # Default to scraping over https. If required, just disable this or change to
      # `http`.
      scheme: https

      # This TLS & bearer token file config is used to connect to the actual scrape
      # endpoints for cluster components. This is separate to discovery auth
      # configuration because discovery & scraping are two separate concerns in
      # Prometheus. The discovery auth config is automatic if Prometheus runs inside
      # the cluster. Otherwise, more config options have to be provided within the
      # <kubernetes_sd_config>.
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        # If your node certificates are self-signed or use a different CA to the
        # master CA, then disable certificate verification below. Note that
        # certificate verification is an integral part of a secure infrastructure
        # so this should only be disabled in a controlled environment. You can
        # disable certificate verification by uncommenting the line below.
        #
        insecure_skip_verify: true
      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token

      kubernetes_sd_configs:
        - role: node

      relabel_configs:
        - action: labelmap
          regex: __meta_kubernetes_node_label_(.+)
        - target_label: __address__
          replacement: kubernetes.default.svc:443
        - source_labels: [__meta_kubernetes_node_name]
          regex: (.+)
          target_label: __metrics_path__
          replacement: /api/v1/nodes/$1/proxy/metrics


    - job_name: 'kubernetes-nodes-cadvisor'

      # Default to scraping over https. If required, just disable this or change to
      # `http`.
      scheme: https

      # This TLS & bearer token file config is used to connect to the actual scrape
      # endpoints for cluster components. This is separate to discovery auth
      # configuration because discovery & scraping are two separate concerns in
      # Prometheus. The discovery auth config is automatic if Prometheus runs inside
      # the cluster. Otherwise, more config options have to be provided within the
      # <kubernetes_sd_config>.
      tls_config:
        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt
        # If your node certificates are self-signed or use a different CA to the
        # master CA, then disable certificate verification below. Note that
        # certificate verification is an integral part of a secure infrastructure
        # so this should only be disabled in a controlled environment. You can
        # disable certificate verification by uncommenting the line below.
        #
        insecure_skip_verify: true
      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token

      kubernetes_sd_configs:
        - role: node

      # This configuration will work only on kubelet 1.7.3+
      # As the scrape endpoints for cAdvisor have changed
      # if you are using older version you need to change the replacement to
      # replacement: /api/v1/nodes/$1:4194/proxy/metrics
      # more info here https://github.com/coreos/prometheus-operator/issues/633
      relabel_configs:
        - action: labelmap
          regex: __meta_kubernetes_node_label_(.+)
        - target_label: __address__
          replacement: kubernetes.default.svc:443
        - source_labels: [__meta_kubernetes_node_name]
          regex: (.+)
          target_label: __metrics_path__
          replacement: /api/v1/nodes/$1/proxy/metrics/cadvisor

    # Scrape config for service endpoints.
    #
    # The relabeling allows the actual service scrape endpoint to be configured
    # via the following annotations:
    #
    # * `prometheus.io/scrape`: Only scrape services that have a value of `true`
    # * `prometheus.io/scheme`: If the metrics endpoint is secured then you will need
    # to set this to `https` & most likely set the `tls_config` of the scrape config.
    # * `prometheus.io/path`: If the metrics path is not `/metrics` override this.
    # * `prometheus.io/port`: If the metrics are exposed on a different port to the
    # service then set this appropriately.
    # * `prometheus.io/param-<NAME>`: Sets the HTTP URL parameters <NAME> to the value
    # of the annotation
    - job_name: 'kubernetes-service-endpoints'

      kubernetes_sd_configs:
        - role: endpoints

      relabel_configs:
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scrape]
          action: keep
          regex: true
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scheme]
          action: replace
          target_label: __scheme__
          regex: (https?)
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_path]
          action: replace
          target_label: __metrics_path__
          regex: (.+)
        - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]
          action: replace
          target_label: __address__
          regex: ([^:]+)(?::\d+)?;(\d+)
          replacement: $1:$2
        - action: labelmap
          regex: __meta_kubernetes_service_annotation_prometheus_io_param_(.+)
          replacement: __param_$1
        - action: labelmap
          regex: __meta_kubernetes_service_label_(.+)
        - source_labels: [__meta_kubernetes_namespace]
          action: replace
          target_label: kubernetes_namespace
        - source_labels: [__meta_kubernetes_service_name]
          action: replace
          target_label: kubernetes_name
        - source_labels: [__meta_kubernetes_pod_node_name]
          action: replace
          target_label: kubernetes_node

    - job_name: 'prometheus-pushgateway'
      honor_labels: true

      kubernetes_sd_configs:
        - role: service

      relabel_configs:
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_probe]
          action: keep
          regex: pushgateway

    # Example scrape config for probing services via the Blackbox Exporter.
    #
    # The relabeling allows the actual service scrape endpoint to be configured
    # via the following annotations:
    #
    # * `prometheus.io/probe`: Only probe services that have a value of `true`
    - job_name: 'kubernetes-services'

      metrics_path: /probe
      params:
        module: [http_2xx]

      kubernetes_sd_configs:
        - role: service

      relabel_configs:
        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_probe]
          action: keep
          regex: true
        - source_labels: [__address__]
          target_label: __param_target
        - target_label: __address__
          replacement: blackbox
        - source_labels: [__param_target]
          target_label: instance
        - action: labelmap
          regex: __meta_kubernetes_service_label_(.+)
        - source_labels: [__meta_kubernetes_namespace]
          target_label: kubernetes_namespace
        - source_labels: [__meta_kubernetes_service_name]
          target_label: kubernetes_name

    # Example scrape config for pods
    #
    # The relabeling allows the actual pod scrape endpoint to be configured via the
    # following annotations:
    #
    # * `prometheus.io/scrape`: Only scrape pods that have a value of `true`
    # * `prometheus.io/path`: If the metrics path is not `/metrics` override this.
    # * `prometheus.io/port`: Scrape the pod on the indicated port instead of the default of `9102`.
    # * `prometheus.io/param-<NAME>`: Sets the HTTP URL parameters <NAME> to the value
    # of the annotation
    - job_name: 'kubernetes-pods'

      kubernetes_sd_configs:
        - role: pod

      relabel_configs:
        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]
          action: keep
          regex: true
        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]
          action: replace
          target_label: __metrics_path__
          regex: (.+)
        - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]
          action: replace
          regex: ([^:]+)(?::\d+)?;(\d+)
          replacement: $1:$2
          target_label: __address__
        - action: labelmap
          regex: __meta_kubernetes_pod_annotation_prometheus_io_param_(.+)
          replacement: __param_$1
        - action: labelmap
          regex: __meta_kubernetes_pod_label_(.+)
        - source_labels: [__meta_kubernetes_namespace]
          action: replace
          target_label: kubernetes_namespace
        - source_labels: [__meta_kubernetes_pod_name]
          action: replace
          target_label: kubernetes_pod_name
EOF
}
