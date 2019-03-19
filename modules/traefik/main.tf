resource "helm_release" "traefik" {
  name       = "${var.release_name}"
  chart      = "${var.chart_name}"
  repository = "${var.chart_repository}"
  version    = "${var.chart_version}"
  namespace  = "${var.chart_namespace}"

  values = [
    "${data.template_file.values.rendered}",
  ]
}

locals {
  static_ip = "${var.internal_static_ip ? element(concat(google_compute_address.internal.*.address, list("")), 0) : element(concat(google_compute_address.external.*.address, list("")), 0)}"

  consul_enabled = "${var.enable_consul_kv == "true"}"

  consul_kv_yaml = <<EOF
consul:
  # Fallback if the HOST_IP bit is missing or fails
  endpoint: "consul.service.consul:8500"
  watch: true
  prefix: "${var.consul_kv_prefix}"
EOF

  consul_kv = "${indent(2, local.consul_kv_yaml)}"

  env = [
    {
      name = "HOST_IP"

      valueFrom = {
        fieldRef = {
          fieldPath = "status.hostIP"
        }
      }
    },
  ]

  consul_startup_args = [
    "--consul",
    "--consul.watch",
    "--consul.prefix=${var.consul_kv_prefix}",
    "--consul.endpoint=$$(HOST_IP):8500",
  ]

  # Terraform < 0.12 does not support conditional lists. So... workaround
  # See https://github.com/hashicorp/terraform/issues/12453
  all_startup_args = "${concat(local.consul_startup_args, var.startup_arguments)}"

  startup_arguments = "${slice(local.all_startup_args, local.consul_enabled ? 0 : 4, length(local.all_startup_args))}"

  internal_service_annotation {
    "cloud.google.com/load-balancer-type" = "${var.internal_static_ip ? "Internal" : "External"}"
  }

  acme_enabled                = "${var.acme_enabled == "true"}"
  acme_dns_provider_variables = "${var.acme_dns_provider}: ${jsonencode(var.acme_dns_provider_variables)}"

  pod_annotations = "${merge(map("checksum/acme_vars", "${sha256(local.acme_dns_provider_variables)}"), var.pod_annotations)}"
}

data "template_file" "values" {
  template = "${file("${path.module}/templates/values.yaml")}"

  vars {
    image     = "${var.traefik_image_name}"
    image_tag = "${var.traefik_image_tag}"
    replicas  = "${var.replicas}"

    rbac_enabled = "${var.rbac_enabled}"

    service_type            = "${var.service_type}"
    lb_source_range         = "${jsonencode(var.lb_source_range)}"
    external_traffic_policy = "${var.external_traffic_policy}"
    whitelist_source_range  = "${jsonencode(var.whitelist_source_range)}"
    node_port_http          = "${var.node_port_http}"
    node_port_https         = "${var.node_port_https}"

    service_annotations = "${jsonencode(merge(local.internal_service_annotation, var.service_annotations))}"
    service_labels      = "${jsonencode(var.service_labels)}"

    pod_annotations       = "${jsonencode(local.pod_annotations)}"
    pod_labels            = "${jsonencode(var.pod_labels)}"
    pod_disruption_budget = "${jsonencode(var.pod_disruption_budget)}"
    pod_priority_class    = "${var.pod_priority_class}"

    deployment_strategy         = "${jsonencode(var.deployment_strategy)}"
    http_host_port_binding      = "${var.http_host_port_binding}"
    https_host_port_binding     = "${var.https_host_port_binding}"
    dashboard_host_port_binding = "${var.dashboard_host_port_binding}"

    static_ip = "${local.static_ip}"
    root_ca   = "${jsonencode(var.root_ca)}"
    debug     = "${var.debug}"

    cpu_request    = "${var.cpu_request}"
    memory_request = "${var.memory_request}"
    cpu_limit      = "${var.cpu_limit}"
    memory_limit   = "${var.memory_limit}"

    node_selector = "${jsonencode(var.node_selector)}"
    affinity      = "${jsonencode(var.affinity)}"
    tolerations   = "${jsonencode(var.tolerations)}"

    namespaces     = "${jsonencode(var.namespaces)}"
    label_selector = "${var.label_selector}"
    ingress_class  = "${var.ingress_class}"

    enable_consul_kv = "${var.enable_consul_kv}"
    consul_kv        = "${local.consul_enabled ? local.consul_kv : ""}"
    consul_kv_prefix = "${var.consul_kv_prefix}"

    ssl_enabled            = "${var.ssl_enabled}"
    ssl_enforced           = "${var.ssl_enforced}"
    ssl_permanent_redirect = "${var.ssl_permanent_redirect}"
    ssl_min_version        = "${var.ssl_min_version}"
    ssl_ciphersuites       = "${jsonencode(var.ssl_ciphersuites)}"

    acme_enabled         = "${var.acme_enabled}"
    acme_email           = "${var.acme_email}"
    acme_on_host_rule    = "${var.acme_on_host_rule}"
    acme_staging         = "${var.acme_staging}"
    acme_logging         = "${var.acme_logging}"
    acme_domains_enabled = "${length(var.acme_domains) > 0 ? "true" : "false"}"
    acme_domains         = "${jsonencode(var.acme_domains)}"

    acme_challenge              = "${var.acme_challenge}"
    acme_delay_before_check     = "${var.acme_delay_before_check}"
    acme_dns_provider           = "${var.acme_dns_provider}"
    acme_dns_provider_variables = "${local.acme_dns_provider_variables}"

    dashboard_enabled             = "${var.dashboard_enabled}"
    dashboard_domain              = "${var.dashboard_domain}"
    dashboard_service_type        = "${var.dashboard_service_type}"
    dashboard_service_annotations = "${jsonencode(var.dashboard_service_annotations)}"
    dashboard_ingress_annotations = "${jsonencode(var.dashboard_ingress_annotations)}"
    dashboard_ingress_labels      = "${jsonencode(var.dashboard_ingress_labels)}"
    dashboard_ingress_tls         = "${jsonencode(var.dashboard_ingress_tls)}"
    dashboard_auth                = "${jsonencode(var.dashboard_auth)}"
    dashboard_recent_errors       = "${var.dashboard_recent_errors}"

    prometheus_enabled         = "${var.prometheus_enabled}"
    prometheus_restrict_access = "${var.prometheus_restrict_access}"

    env               = "${jsonencode(local.env)}"
    startup_arguments = "${jsonencode(local.startup_arguments)}"

    traefik_log_format  = "${var.traefik_log_format}"
    access_logs_enabled = "${var.access_logs_enabled}"
    access_log_format   = "${var.access_log_format}"

    datadog_enabled       = "${var.datadog_enabled}"
    datadog_address       = "${var.datadog_address}"
    datadog_push_interval = "${var.datadog_push_interval}"

    statsd_enabled       = "${var.statsd_enabled}"
    statsd_address       = "${var.statsd_address}"
    statsd_push_interval = "${var.statsd_push_interval}"

    tracing_enabled      = "${var.tracing_enabled}"
    tracing_service_name = "${var.tracing_service_name}"
    tracing_settings     = "${var.tracing_enabled == "true" ? "${var.tracing_backend}: ${jsonencode(var.tracing_settings)}" : ""}"

    secret_files = "${jsonencode(var.secret_files)}"

    # Disabled for now because of https://github.com/hashicorp/terraform/issues/17033
    # prometheus_buckets         = "${jsonencode(var.prometheus_buckets)}"
  }
}

resource "google_compute_address" "external" {
  count = "${var.internal_static_ip ? 0 : 1}"

  name         = "${var.static_ip_name}"
  address_type = "EXTERNAL"
}

resource "google_compute_address" "internal" {
  count = "${var.internal_static_ip ? 1 : 0}"

  name         = "${var.static_ip_name}"
  address_type = "INTERNAL"
  subnetwork   = "${var.internal_static_ip_subnetwork}"
}
