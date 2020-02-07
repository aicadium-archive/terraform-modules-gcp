resource "helm_release" "consul_backup" {
  name       = var.release_name
  chart      = var.chart_name
  repository = data.helm_repository.selected.metadata[0].name
  version    = var.chart_version
  namespace  = var.namespace

  max_history = var.max_history

  values = [
    data.template_file.values.rendered,
  ]
}

data "helm_repository" "selected" {
  name = var.chart_repository
  url  = var.chart_repository_url
}

data "template_file" "values" {
  template = file("${path.module}/templates/values.yaml")

  vars = {
    schedule = var.schedule
    env      = jsonencode(var.env)

    image       = var.image
    tag         = var.tag
    pull_policy = var.pull_policy

    consul_address = var.consul_address

    node_selector = jsonencode(var.node_selector)
    tolerations   = jsonencode(var.tolerations)
    affinity      = jsonencode(var.affinity)

    gcs_bucket = var.gcp_bucket_name
    gcs_prefix = var.gcs_prefix

    vault_address = var.vault_address
    vault_ca      = jsonencode(var.vault_ca)

    vault_auth_path = var.kubernetes_auth_path
    vault_auth_role = vault_kubernetes_auth_backend_role.job.role_name
    service_account = var.service_account_name

    vault_gcp_path = local.gcp_secret_path

    ttl_seconds = var.ttl_seconds
  }
}
