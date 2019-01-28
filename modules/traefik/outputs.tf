output "values" {
  description = "Rendered Values file"
  value       = "${data.template_file.values.rendered}"
}
