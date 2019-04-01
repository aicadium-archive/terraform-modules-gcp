resource "helm_release" "consul" {
  name       = "${var.release_name}"
  chart      = "${var.chart_name}"
  repository = "${var.chart_repository}"
  version    = "${var.chart_version}"
  namespace  = "${var.chart_namespace}"

  values = [
    "${data.template_file.general.rendered}",
    "${data.template_file.alertmanager.rendered}",
  ]
}

data "template_file" "general" {
  template = "${file("${path.module}/templates/general.yaml")}"

  vars {
    image_pull_secrets = "${jsonencode(var.image_pull_secrets)}"
  }
}

data "template_file" "alertmanager" {
  template = "${file("${path.module}/templates/alertmanager.yaml")}"

  vars {
    enable = "${var.alertmanager_enable}"

    repository  = "${var.alertmanager_repository}"
    tag         = "${var.alertmanager_tag}"
    pull_policy = "${var.alertmanager_pull_policy}"

    replica   = "${var.alertmanager_replica}"
    resources = "${jsonencode(var.alertmanager_resources)}"

    annotations      = "${jsonencode(var.alertmanager_annotations)}"
    tolerations      = "${jsonencode(var.alertmanager_tolerations)}"
    node_selector    = "${var.alertmanager_node_selector}"
    affinity         = "${var.alertmanager_affinity}"
    security_context = "${jsonencode(var.alertmanger_security_context)}"

    priority_class_name = "${var.alertmanager_priority_class_name}"
    extra_args          = "${jsonencode(var.alertmanager_extra_args)}"
    extra_env           = "${jsonencode(var.alertmanager_extra_env)}"

    prefix_url = "${var.alertmanager_prefix_url}"
    base_url   = "${var.alertmanager_base_url}"

    config_map_override_name = "${var.alertmanager_config_map_override_name}"
    config_from_secret       = "${var.alertmanager_config_from_secret}"
    config_file_name         = "${var.alertmanager_config_file_name}"

    headless_annotations = "${jsonencode(var.alertmanager_headless_annotations)}"
    headless_labels      = "${jsonencode(var.alertmanager_headless_labels)}"

    service_annotations      = "${jsonencode(var.alertmanager_service_annotations)}"
    service_labels           = "${jsonencode(var.alertmanager_service_labels)}"
    service_cluster_ip       = "${jsonencode(var.alertmanager_service_cluster_ip)}"
    service_external_ips     = "${jsonencode(var.alertmanager_service_external_ips)}"
    service_lb_ip            = "${jsonencode(var.alertmanager_service_lb_ip)}"
    service_lb_source_ranges = "${jsonencode(var.alertmanager_service_lb_source_ranges)}"
    service_port             = "${var.alertmanager_service_port}"
    service_type             = "${var.alertmanager_service_type}"

    ingress_enabled      = "${var.alertmanager_ingress_enabled}"
    ingress_annotations  = "${jsonencode(var.alertmanager_ingress_annotations)}"
    ingress_extra_labels = "${jsonencode(var.alertmanager_ingress_extra_labels)}"
    ingress_hosts        = "${jsonencode(var.alertmanager_ingress_hosts)}"
    ingress_tls          = "${jsonencode(var.alertmanager_ingress_tls)}"

    pv_enabled        = "${var.alertmanager_pv_enabled}"
    pv_access_modes   = "${jsonencode(var.alertmanager_pv_access_modes)}"
    pv_annotations    = "${jsonencode(var.alertmanager_pv_annotations)}"
    pv_existing_claim = "${var.alertmanager_pv_existing_claim}"
    pv_size           = "${var.alertmanager_pv_size}"
  }
}
