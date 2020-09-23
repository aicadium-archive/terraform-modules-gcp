resource "helm_release" "cloudsql_backup" {
  name       = var.release_name
  chart      = var.chart_name
  repository = var.chart_repository_url
  version    = var.chart_version
  namespace  = var.namespace

  max_history = var.max_history

  values = [
    data.template_file.values.rendered,
  ]
}

locals {
  entrypoint = <<EOF
#!/bin/sh
set -xeu

if [ -z $${GOOGLE_CREDENTIALS+x} ]; then
  echo "Using Default Credentials"
else
  gcloud auth activate-service-account --key-file="$GOOGLE_CREDENTIALS"
fi

gcloud sql backups create \
  --instance "${var.cloudsql_instance}" \
  --project "${var.cloudsql_project}" \
  --description "Manual Backup at $(date)"
EOF
}

data "template_file" "values" {
  template = file("${path.module}/templates/values.yaml")

  vars = {
    schedule = var.schedule
    env      = jsonencode(var.env)

    image       = var.image
    tag         = var.tag
    pull_policy = var.pull_policy

    node_selector = jsonencode(var.node_selector)
    tolerations   = jsonencode(var.tolerations)
    affinity      = jsonencode(var.affinity)

    enable_vault_agent = var.enable_vault_agent
    vault_address      = var.vault_address
    vault_ca           = jsonencode(var.vault_ca)

    vault_auth_path = var.kubernetes_auth_path
    vault_auth_role = var.enable_vault_agent ? vault_kubernetes_auth_backend_role.job[0].role_name : ""

    service_account = var.service_account_name
    service_account_annotations = jsonencode(var.enable_workload_identity ? {
      "iam.gke.io/gcp-service-account" = var.enable_workload_identity ? google_service_account.workload_identity[0].email : ""
    } : {})

    vault_gcp_path = local.gcp_secret_path

    ttl_seconds = var.ttl_seconds

    entrypoint = jsonencode(coalesce(var.entrypoint, local.entrypoint))
  }
}

resource "google_project_service" "cloudsql_admin" {
  project = var.cloudsql_project
  service = "sqladmin.googleapis.com"

  disable_on_destroy = false
}

resource "google_project_iam_custom_role" "backup" {
  role_id     = var.gcp_role_id
  title       = var.gcp_role_title
  description = var.gcp_role_description

  permissions = [
    "cloudsql.backupRuns.create",
    "cloudsql.instances.get",
  ]

  project = var.cloudsql_project
}
