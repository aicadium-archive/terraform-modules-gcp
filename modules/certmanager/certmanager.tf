resource "null_resource" "certmanager_crds" {
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
  depends_on = [null_resource.certmanager_crds]

  name       = "cert-manager"
  repository = data.helm_repository.repository.metadata[0].name
  version    = var.certmanager_chart_version
  chart      = "cert-manager"

  namespace = var.kube_namespace

  values = [
    data.template_file.certmanager.rendered,
  ]
}

data "helm_repository" "repository" {
  name = "amoy"
  url  = "https://charts.amoy.ai"
}

data "template_file" "certmanager" {
  template = file("${path.module}/templates/certmanager.yaml")

  vars = {
    environment         = var.acme_environment
    email               = var.acme_email
    project_id          = var.project_id
    service_account_key = indent(4, base64decode(google_service_account_key.certmanager.private_key))
    certificates        = yamlencode(var.certificates)
  }
}
