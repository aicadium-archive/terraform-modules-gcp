variable "static_ip_name" {
  description = "Name of the Static IP resource to deploy for the Network LB"
}

variable "internal_static_ip" {
  description = "Whether the static IP to reserve is internal"
  default     = false
}

variable "internal_static_ip_subnetwork" {
  description = "The URL of the subnetwork in which to reserve the internal static address"
  default     = ""
}

variable "release_name" {
  description = "Helm release name for Traefik"
  default     = "traefik"
}

variable "chart_name" {
  description = "Helm chart name to provision"

  # Awaiting https://github.com/helm/charts/pull/10928 or similiar
  # default     = "stable/traefik"
  default = "https://github.com/basisai/charts/releases/download/traefik-env/traefik-1.59.3.tgz"
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
  default     = "kube-system"
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

variable "lb_source_range" {
  description = "List of CIDR allowed to access the Network Load balancer. This setting is enforced by GCP Network LB"
  default     = ["0.0.0.0/0"]
}

variable "whitelist_source_range" {
  description = "List of CIDRs allowed to access the Traefik Load balancer. This setting is enforced by Traefik."
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
  default     = ""
}

variable "cpu_limit" {
  description = "CPU limit per Traefik pod"
  default     = ""
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
  default     = {}
}

variable "tolerations" {
  description = "List of map of tolerations for Traefik Pods. See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/"
  default     = []
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

variable "pod_disruption_budget" {
  description = "JSON string for pod disruption budget. See https://kubernetes.io/docs/tasks/run-application/configure-pdb/"
  default     = ""
}

variable "pod_priority_class" {
  description = "Pod priority class name. See https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/"
  default     = ""
}

variable "deployment_strategy" {
  description = "Deployment strategy for the Traefik pods. See https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy"
  default     = {}
}

variable "http_host_port_binding" {
  description = "Whether to enable hostPort binding to host for http."
  default     = "false"
}

variable "https_host_port_binding" {
  description = "Whether to enable hostPort binding to host for https."
  default     = "false"
}

variable "dashboard_host_port_binding" {
  description = "Whether to enable hostPort binding to host for dashboard."
  default     = "false"
}

variable "rbac_enabled" {
  description = "Whether to enable RBAC with a specific cluster role and binding for Traefik"
  default     = "true"
}

variable "namespaces" {
  description = "List of Kubernetes namespaces to watch"
  default     = ["default"]
}

variable "label_selector" {
  description = "Valid Kubernetes ingress label selector to watch"
  default     = ""
}

variable "ingress_class" {
  description = "Value of kubernetes.io/ingress.class annotation to watch - must start with traefik if set"
  default     = "traefik"
}

variable "kv_store_acme" {
  description = "Use the chart to configure Traefik to Store ACME certificates on Consul KV"
  default     = "false"
}

variable "enable_consul_kv" {
  description = "Enable KV Store with Consul"
  default     = "false"
}

variable "consul_kv_prefix" {
  description = "Consul KV configuration store prefix"
  default     = "traefik"
}

variable "root_ca" {
  description = "List of Root CAs for Traefik to trust when encountering backends. Put the contents into the variable"
  default     = []
}

variable "debug" {
  description = "Operator Traefik in Debug mode."
  default     = "false"
}

variable "ssl_enabled" {
  description = "Enable SSL endpoin. You will either need to use the Let's Encrypt ACME certificates or provide your own. Otherwise, Traefik will serve an expired self-signed certificatre"
  default     = "true"
}

variable "ssl_enforced" {
  description = "Enforce SSL by performing a redirect from the non SSL endpoint"
  default     = "true"
}

variable "ssl_permanent_redirect" {
  description = "When redirecting from the non SSL endpoint to the SSL endpoint, use a permanent redirect (301) instead of a temporary one (302)"
  default     = "true"
}

variable "ssl_min_version" {
  description = "Minimum version of SSL to use. See https://docs.traefik.io/configuration/entrypoints/#specify-minimum-tls-version"
  default     = "VersionTLS12"
}

variable "ssl_ciphersuites" {
  description = "List of SSL ciphersuites to use. Leave empty for default. This must match the type of key you use for your certificates"
  default     = []
}

variable "acme_enabled" {
  description = "Enable ACME protocol (Let's Encrypt)"
  default     = "false"
}

variable "acme_email" {
  description = "Email address for ACME certificates"
  default     = ""
}

variable "acme_on_host_rule" {
  description = "Enable certificate generation on frontend Host rules. See https://docs.traefik.io/configuration/acme/#onhostrule"
  default     = "true"
}

variable "acme_staging" {
  description = "Issue certificates from Let's Encrypt staging server"
  default     = "false"
}

variable "acme_logging" {
  description = "Display debug log messages from the ACME client library"
  default     = "true"
}

variable "acme_domains" {
  description = "List of maps of domains to generate ACME certificates for. See https://docs.traefik.io/configuration/acme/#domains for the keys required. Also see https://github.com/helm/charts/blob/15493df5ad0e38da7301bcb4979a07a0dbe5a73c/stable/traefik/values.yaml#L156-L165 for the list format required"
  default     = []
}

variable "acme_challenge" {
  description = "Type of challenge to retrieve certificates. See https://docs.traefik.io/configuration/acme/#acme-challenge"
  default     = "httpChallenge"
}

variable "acme_delay_before_check" {
  description = "By default, the provider will verify the TXT DNS challenge record before letting ACME verify. If acme_delay_before_check is greater than zero, this check is delayed for the configured duration in seconds. Useful when Traefik cannot resolve external DNS queries."
  default     = 0
}

variable "acme_dns_provider" {
  description = "Name of the DNS provider to perform DNS record modification for the DNS-01 challenge. See https://docs.traefik.io/configuration/acme/#dnschallenge"
  default     = "gcloud"
}

variable "acme_dns_provider_variables" {
  description = "Map of environment variables for the DNS provider to perform the DNS challengt. See https://docs.traefik.io/configuration/acme/#dnschallenge"
  default     = {}
}

variable "acme_key_type" {
  description = "Private key type for ACME certificates. Make sure your SSL ciphersuites supports the key type. Available values : EC256, EC384, RSA2048, RSA4096, RSA8192"
  default     = "RSA4096"
}

variable "startup_arguments" {
  description = "List of additional startup arguments for the Traefik pods"
  default     = []
}

variable "node_port_http" {
  description = "Desired nodePort for service of type NodePort used for http requests. Blank will assign a dynamic port"
  default     = "80"
}

variable "node_port_https" {
  description = "Desired nodePort for service of type NodePort used for https requests. Blank will assign a dynamic port"
  default     = "443"
}

variable "traefik_log_format" {
  description = "Log format for Traefik. See https://docs.traefik.io/configuration/logs/#traefik-logs"
  default     = "json"
}

variable "access_logs_enabled" {
  description = "Enable access logs"
  default     = "true"
}

variable "access_log_format" {
  description = "Format of access logs. See https://docs.traefik.io/configuration/logs/#access-logs"
  default     = "json"
}

variable "dashboard_enabled" {
  description = "Enable the Traefik Dashboard"
  default     = "false"
}

variable "dashboard_domain" {
  description = "Domain to listen on the Dashboard Ingress"
  default     = ""
}

variable "dashboard_service_type" {
  description = "Service type for the dashboard service"
  default     = "ClusterIP"
}

variable "dashboard_service_annotations" {
  description = "Annotations for the Traefik dashboard Service definition, specified as a map"
  default     = {}
}

variable "dashboard_ingress_annotations" {
  description = "Annotations for the Traefik dashboard Ingress definition, specified as a map"
  default     = {}
}

variable "dashboard_ingress_labels" {
  description = "Labels for the Traefik dashboard Ingress definition, specified as a map"
  default     = {}
}

variable "dashboard_ingress_tls" {
  description = "TLS settings for the Traefik dashboard Ingress definition"
  default     = {}
}

variable "dashboard_auth" {
  description = "Dashboard authentication settings. See https://docs.traefik.io/configuration/api/#authentication"
  default     = {}
}

variable "dashboard_recent_errors" {
  description = "Number of recent errors to show in the ‘Health’ tab"
  default     = 10
}

variable "prometheus_enabled" {
  description = "Enable the Prometheus metrics server"
  default     = "false"
}

variable "prometheus_restrict_access" {
  description = "Whether to limit access to the metrics port (8080) to the dashboard service. When false, it is accessible on the main Traefik service as well."
  default     = "true"
}

variable "prometheus_buckets" {
  description = "A list of response times (in seconds) - for each list element, Traefik will report all response times less than the element."
  default     = [0.1, 0.3, 1.2, 5.0]
}

variable "datadog_enabled" {
  description = "Enable pushing metrics to Datadog"
  default     = "false"
}

variable "datadog_address" {
  description = "Addess of the Datadog host"
  default     = ""
}

variable "datadog_push_interval" {
  description = "How often to push metrics to Datadog."
  default     = "10s"
}

variable "statsd_enabled" {
  description = "Enable pushing metrics to statsd"
  default     = "false"
}

variable "statsd_address" {
  description = "Addess of the statsd host"
  default     = ""
}

variable "statsd_push_interval" {
  description = "How often to push metrics to statsd."
  default     = "10s"
}

variable "tracing_enabled" {
  description = "Whether to enable request tracing"
  default     = "false"
}

variable "tracing_service_name" {
  description = "Service name to be used in tracing backend"
  default     = "traefik"
}

variable "tracing_backend" {
  description = "One of `jaegar`, `zipkin` or `datadog`"
  default     = ""
}

variable "tracing_settings" {
  description = "Map of settings for the tracing backend. See `templates/values.yaml` for information"
  default     = {}
}

variable "secret_files" {
  description = "KV Map of secret files and their contents"
  default     = {}
}

