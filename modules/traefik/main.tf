resource "helm_release" "traefik" {
  name       = "${var.release_name}"
  chart      = "${var.chart_name}"
  repository = "${var.chart_repository}"
  version    = "${var.chart_version}"

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
    external_lb_cidr        = "${var.external_cidr}"
    external_traffic_policy = "${var.external_traffic_policy}"

    service_annotations = "${var.service_annotations}"
    service_labels      = "${var.service_labels}"
    pod_annotations     = "${var.pod_annotations}"
    pod_labels          = "${var.pod_labels}"

    external_static_ip = "${google_compute_address.external.name}"

    cpu_request    = "${var.cpu_request}"
    memory_request = "${var.memory_request}"
    cpu_limit      = "${var.cpu_limit}"
    memory_limit   = "${var.memory_limit}"

    node_selector = "${var.node_selector}"
    affinity      = "${var.affinity}"
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
