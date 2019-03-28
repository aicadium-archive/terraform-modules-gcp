resource "helm_release" "consul" {
  name       = "${var.release_name}"
  chart      = "${var.chart_name}"
  repository = "${var.chart_repository}"
  version    = "${var.chart_version}"
  namespace  = "${var.chart_namespace}"

  values = [
    "${data.template_file.values.rendered}",
  ]
}

data "google_client_config" "current" {}

data "template_file" "values" {
  template = "${file("${path.module}/templates/values.yaml")}"

  vars {
    image     = "${var.consul_image_name}:${var.consul_image_tag}"
    image_k8s = "${var.consul_k8s_image}:${var.consul_k8s_tag}"

    datacenter    = "${data.google_client_config.current.region}"
    consul_domain = "${var.consul_domain}"

    server_replicas      = "${var.server_replicas}"
    server_storage       = "${var.server_storage}"
    server_storage_class = "${var.server_storage_class}"

    server_cpu_request    = "${var.server_cpu_request}"
    server_memory_request = "${var.server_memory_request}"
    server_cpu_limit      = "${var.server_cpu_limit}"
    server_memory_limit   = "${var.server_memory_limit}"
    server_extra_config   = "${jsonencode(var.server_extra_config)}"
    server_extra_volumes  = "${jsonencode(var.server_extra_volumes)}"
    server_affinity       = "${jsonencode(var.server_affinity)}"
    server_tolerations    = "${jsonencode(var.server_tolerations)}"
    server_priority_class = "${var.server_priority_class}"

    client_enabled        = "${var.client_enabled}"
    client_cpu_request    = "${var.client_cpu_request}"
    client_memory_request = "${var.client_memory_request}"
    client_cpu_limit      = "${var.client_cpu_limit}"
    client_memory_limit   = "${var.client_memory_limit}"
    client_extra_config   = "${jsonencode(var.client_extra_config)}"
    client_extra_volumes  = "${jsonencode(var.client_extra_volumes)}"
    client_tolerations    = "${jsonencode(var.client_tolerations)}"
    client_priority_class = "${var.client_priority_class}"

    enable_sync_catalog      = "${var.enable_sync_catalog}"
    sync_by_default          = "${var.sync_by_default}"
    sync_to_consul           = "${var.sync_to_consul}"
    sync_to_k8s              = "${var.sync_to_k8s}"
    sync_k8s_prefix          = "${var.sync_k8s_prefix}"
    sync_k8s_tag             = "${var.sync_k8s_tag}"
    sync_cluster_ip_services = "${var.sync_cluster_ip_services}"
    sync_node_port_type      = "${var.sync_node_port_type}"

    enable_ui          = "${var.enable_ui}"
    ui_service_type    = "${var.ui_service_type}"
    ui_annotations     = "${jsonencode(var.ui_annotations)}"
    ui_additional_spec = "${jsonencode(var.ui_additional_spec)}"

    enable_connect_inject             = "${var.enable_connect_inject}"
    connect_inject_by_default         = "${var.connect_inject_by_default}"
    connect_inject_namespace_selector = "${var.connect_inject_namespace_selector}"
  }
}
