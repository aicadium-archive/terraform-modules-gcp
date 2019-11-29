locals {
  certmanager_enabled = var.certmanager_enabled ? 1 : 0
}

resource "null_resource" "certmanager_crds" {
  count = local.certmanager_enabled

  triggers = {
    certmanager_crd_version = var.certmanager_crd_version
  }

  provisioner "local-exec" {
    command = "kubectl apply --context ${var.kube_context} --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-${var.certmanager_crd_version}/deploy/manifests/00-crds.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete --context ${var.kube_context} -f https://raw.githubusercontent.com/jetstack/cert-manager/release-${var.certmanager_crd_version}/deploy/manifests/00-crds.yaml"
  }
}

resource "helm_release" "certmanager" {
  count = local.certmanager_enabled

  depends_on = [null_resource.certmanager_crds]

  name       = "cert-manager"
  repository = data.helm_repository.repository[0].metadata[0].name
  version    = var.certmanager_chart_version
  chart      = "cert-manager-aio"

  namespace = var.kube_namespace

  values = [
    data.template_file.certmanager[0].rendered,
  ]
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
