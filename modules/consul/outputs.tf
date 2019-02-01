output "kube_dns_service_cluster_ip" {
  description = "Cluster IP of the Consul DNS service"
  value       = "${data.kubernetes_service.consul_dns.spec.0.cluster_ip}"
}

output "values" {
  description = "Values from the Consul Helm chart"
  value       = "${helm_release.consul.metadata.0.values}"
}
