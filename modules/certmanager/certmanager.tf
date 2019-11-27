resource "null_resource" "certmanager_crds" {
  triggers = {
    certmanager_crd_version = var.certmanager_crd_version
  }

  provisioner "local-exec" {
    command = "kubectl apply --validate=false -f https://raw.githubusercontent.com/jetstack/cert-manager/release-${var.certmanager_crd_version}/deploy/manifests/00-crds.yaml"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "kubectl delete -f https://raw.githubusercontent.com/jetstack/cert-manager/release-${var.certmanager_crd_version}/deploy/manifests/00-crds.yaml"
  }
}

resource "helm_release" "certmanager" {
  depends_on = [null_resource.certmanager_crds]

  name       = "cert-manager"
  repository = "amoy"
  version    = var.certmanager_chart_version
  chart      = "cert-manager"

  namespace = var.service_namespace

  values = [
    data.template_file.certmanager.rendered,
  ]
}

locals {
  certificates = [
    {
      common_name = "*.${var.dns_base_name}"
      san = [
        var.dns_base_name,
        "*.${var.dns_base_name}",
      ]
      renew_before = var.certificate_renew_before
    },
    {
      common_name = "*.${var.external_dns_base_name}"
      san = [
        var.external_dns_base_name,
        "*.${var.external_dns_base_name}",
      ]
      renew_before = var.certificate_renew_before
    }
  ]
}

data "template_file" "certmanager" {
  template = file("${path.module}/templates/certmanager.yaml")

  vars = {
    environment         = "staging"
    email               = var.acme_email
    project_id          = var.project_id
    service_account_key = indent(4, base64decode(google_service_account_key.certmanager.private_key))
    certificates        = yamlencode(local.certificates)
  }
}
