locals {
  certmanager_enabled = var.certmanager_enabled ? 1 : 0
}

resource "null_resource" "certmanager_crds" {
  count = local.certmanager_enabled

  triggers = {
    certmanager_crd_version = var.certmanager_crd_version
    id                      = local_file.cluster_ca_cert.id
  }

  provisioner "local-exec" {
    command = "kubectl apply --certificate-authority $CA_CERT_PATH --server $HOST --token $TOKEN --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-${var.certmanager_crd_version}/deploy/manifests/00-crds.yaml"

    environment = {
      CA_CERT_PATH = local_file.cluster_ca_cert.filename
      HOST         = "https://${var.cluster_host}"
      TOKEN        = var.cluster_token
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete --certificate-authority $CA_CERT_PATH --server $HOST --token $TOKEN -f https://raw.githubusercontent.com/jetstack/cert-manager/release-${var.certmanager_crd_version}/deploy/manifests/00-crds.yaml"

    environment = {
      CA_CERT_PATH = local_file.cluster_ca_cert.filename
      HOST         = "https://${var.cluster_host}"
      TOKEN        = var.cluster_token
    }
  }
}

resource "local_file" "cluster_ca_cert" {
  content_base64  = var.cluster_ca_cert_base64
  filename        = "${path.module}/.cluster_ca_cert"
  file_permission = "0600"
}

resource "helm_release" "certmanager" {
  count = local.certmanager_enabled

  depends_on = [null_resource.certmanager_crds]

  name       = "cert-manager"
  repository = data.helm_repository.repository[0].metadata[0].name
  version    = var.certmanager_chart_version
  chart      = "cert-manager-aio"

  namespace = var.kube_namespace

  max_history = var.max_history

  values = concat([data.template_file.certmanager[0].rendered], var.additional_values)
}

data "helm_repository" "repository" {
  count = local.certmanager_enabled

  name = "amoy"
  url  = "https://charts.amoy.ai"
}

data "template_file" "certmanager" {
  count = local.certmanager_enabled

  template = file("${path.module}/templates/certmanager.yaml")

  vars = {
    environment         = var.acme_environment
    email               = var.acme_email
    project_id          = var.project_id
    service_account_key = indent(4, base64decode(google_service_account_key.certmanager[0].private_key))
    certificates        = yamlencode(var.certificates)
  }
}
