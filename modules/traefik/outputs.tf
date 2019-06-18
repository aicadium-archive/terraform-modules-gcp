output "values" {
  description = "Rendered Values file"
  value       = data.template_file.values.rendered
}

output "static_ip" {
  description = "Address of the Traefik Load balancer static IP"
  value       = local.static_ip
}
