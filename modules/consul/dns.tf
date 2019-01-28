# Configure DNS for Consul
# https://www.consul.io/docs/platform/k8s/dns.html

data "kubernetes_service" "consul_dns" {
  depends_on = ["helm_release.consul"]

  metadata {
    name      = "consul-dns"
    namespace = "${var.chart_namespace}"
  }
}

resource "kubernetes_config_map" "consul_dns" {
  count = "${var.configure_kube_dns ? 1 : 0}"

  metadata {
    labels {
      "addonmanager.kubernetes.io/mode" = "EnsureExists"
    }

    name      = "kube-dns"
    namespace = "kube-system"
  }

  data = {
    "stubDomains" = <<EOF
{ "consul": ["${data.kubernetes_service.consul_dns.spec.0.cluster_ip}"] }
EOF
  }

}
