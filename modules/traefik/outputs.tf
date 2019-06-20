output "values" {
  description = "Rendered Values file"
  value       = local.rendered_values
}

output "static_ip" {
  description = "Address of the Traefik Load balancer static IP"
  value       = local.static_ip
}
