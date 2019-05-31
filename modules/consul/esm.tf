# Deploy Consul ESM
resource "helm_release" "consul_esm" {
  count = "${var.enable_esm ? 1 : 0}"

  name       = "${var.esm_release_name}"
  chart      = "${var.esm_chart_name}"
  repository = "${var.esm_chart_repository}"
  version    = "${var.esm_chart_version}"
  namespace  = "${var.chart_namespace}"

  values = [
    "${data.template_file.esm_values.rendered}",
  ]
}

data "template_file" "esm_values" {
  template = "${file("${path.module}/templates/esm-values.yaml")}"

  vars {
    replica = "${var.esm_replica}"

    image     = "${var.esm_image}"
    tag       = "${var.esm_tag}"
    resources = "${jsonencode(var.esm_resources)}"
    env       = "${jsonencode(var.esm_env)}"

    log_level              = "${var.esm_log_level}"
    service_name           = "${var.esm_service_name}"
    service_tag            = "${var.esm_service_tag}"
    kv_path                = "${var.esm_kv_path}"
    external_node_meta     = "${jsonencode(var.esm_external_node_meta)}"
    node_reconnect_timeout = "${var.esm_node_reconnect_timeout}"
    node_probe_interval    = "${var.esm_node_probe_interval}"
    http_addr              = "${var.esm_http_addr}"
    ping_type              = "${var.esm_ping_type}"

    init_container_set_sysctl = "${var.esm_init_container_set_sysctl}"
  }
}
