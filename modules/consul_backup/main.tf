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

    enable_vault_agent = var.enable_vault_agent
    vault_auth_path    = var.kubernetes_auth_path
    vault_auth_role    = var.enable_vault_agent ? vault_kubernetes_auth_backend_role.job[0].role_name : ""

    service_account = var.service_account_name
    service_account_annotations = jsonencode(var.enable_workload_identity ? {
      "iam.gke.io/gcp-service-account" = var.enable_workload_identity ? google_service_account.workload_identity[0].email : ""
    } : {})

    vault_gcp_path = local.gcp_secret_path

    ttl_seconds = var.ttl_seconds
  }
}

resource "google_project_iam_custom_role" "object_writer" {
  role_id     = var.gcp_role_id
  title       = var.gcp_role_title
  description = var.gcp_role_description

  permissions = [
    "storage.objects.create",
    "storage.objects.list",
  ]

  project = var.gcp_bucket_project
}
