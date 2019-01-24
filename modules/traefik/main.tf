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

data "template_file" "values" {
  template = "${file("${path.module}/templates/values.yaml")}"

  vars {
    image     = "${var.traefik_image_name}"
    image_tag = "${var.traefik_image_tag}"
    replicas  = "${var.replicas}"

    rbac_enabled = "${var.rbac_enabled}"

    service_type            = "${var.service_type}"
    external_lb_cidr        = "${jsonencode(var.external_cidr)}"
    external_traffic_policy = "${var.external_traffic_policy}"

    service_annotations = "${jsonencode(var.service_annotations)}"
    service_labels      = "${jsonencode(var.service_labels)}"
    pod_annotations     = "${jsonencode(var.pod_annotations)}"
    pod_labels          = "${jsonencode(var.pod_labels)}"

    external_static_ip = "${google_compute_address.external.address}"

    cpu_request    = "${var.cpu_request}"
    memory_request = "${var.memory_request}"
    cpu_limit      = "${var.cpu_limit}"
    memory_limit   = "${var.memory_limit}"

    node_selector = "${jsonencode(var.node_selector)}"
    affinity      = "${jsonencode(var.affinity)}"

    namespaces     = "${jsonencode(var.namespaces)}"
    label_selector = "${var.label_selector}"
    ingress_class  = "${var.ingress_class}"
  }
}

resource "google_compute_address" "external" {
  name         = "${var.external_static_ip_name}"
  address_type = "EXTERNAL"
}

resource "google_compute_address" "internal" {
  count = "${var.internal_static_ip_name != "" ? 1 : 0}"

  name         = "${var.internal_static_ip_name}"
  address_type = "INTERNAL"
  subnetwork   = "${var.internal_static_ip_subnetwork}"
}
