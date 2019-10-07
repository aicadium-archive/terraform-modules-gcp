locals {
  enabled = var.enabled ? 1 : 0
}

resource "helm_release" "notifier" {
  count = local.enabled

  name       = var.release_name
  chart      = var.chart_name
  repository = data.helm_repository.selected[0].metadata[0].name
  version    = var.chart_version
  namespace  = var.namespace

  values = [
    data.template_file.values[0].rendered,
  ]
}

data "helm_repository" "selected" {
  count = local.enabled

  name = var.chart_repository
  url  = var.chart_repository_url
}

data "template_file" "values" {
  count = local.enabled

  template = file("${path.module}/templates/values.yaml")

  vars = {
    schedule    = var.schedule
    ttl_seconds = var.ttl_seconds

    image       = var.image
    tag         = var.tag
    pull_policy = var.pull_policy

    gcp_billing_account_id = var.gcp_billing_account_id
    gcp_project_ids        = var.gcp_project_ids
    gcp_sa_key             = var.gcp_sa_key
    slack_webhook          = var.slack_webhook

    resources = jsonencode(var.resources)

    node_selector = jsonencode(var.node_selector)
    tolerations   = jsonencode(var.tolerations)
    affinity      = jsonencode(var.affinity)
    labels        = jsonencode(var.labels)
    annotations   = jsonencode(var.annotations)
  }
}
