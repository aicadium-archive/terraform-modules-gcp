resource "helm_release" "vault" {
  depends_on = [google_container_node_pool.vault]

  name       = var.release_name
  chart      = var.chart_name
  repository = var.chart_repository
  version    = var.chart_version
  namespace  = var.kubernetes_namespace

  timeout = var.timeout

  max_history = var.max_history

  values = [
    templatefile("${path.module}/templates/values.yaml", local.chart_values),
  ]
}

locals {
  chart_values = {
    global_enabled = var.global_enabled
    tls_disabled   = var.tls_disabled

    ####################################
    # Injector
    ####################################
    injector_enabled          = var.injector_enabled
    external_vault_addr       = var.external_vault_addr
    injector_image_repository = var.injector_image_repository
    injector_image_tag        = var.injector_image_tag
    injector_log_level        = var.injector_log_level
    injector_log_format       = var.injector_log_format

    injector_resources   = jsonencode(var.injector_resources)
    injector_env         = jsonencode(var.injector_env)
    injector_affinity    = jsonencode(var.injector_affinity)
    injector_tolerations = jsonencode(var.injector_tolerations)

    agent_image_repository = var.agent_image_repository
    agent_image_tag        = var.agent_image_tag

    auth_path          = var.auth_path
    revoke_on_shutdown = var.revoke_on_shutdown

    namespace_selector = jsonencode(var.namespace_selector)

    ####################################
    # Server
    ####################################
    server_image_repository = var.server_image_repository
    server_image_tag        = var.server_image_tag
    server_update_strategy  = var.server_update_strategy
    server_labels           = jsonencode(var.server_labels)
    server_annotations      = jsonencode(var.server_annotations)

    server_resources        = jsonencode(var.server_resources)
    server_extra_containers = jsonencode(var.server_extra_containers)
    server_share_pid        = var.server_share_pid
    server_extra_args       = var.server_extra_args
    server_env              = jsonencode(var.server_env)
    server_secret_env       = jsonencode(var.server_secret_env)
    server_volumes          = jsonencode(concat([local.tls_volume], var.server_volumes))
    server_affinity         = jsonencode(var.server_affinity)
    server_tolerations      = jsonencode(var.server_tolerations)

    server_readiness_probe_enable = var.server_readiness_probe_enable
    server_readiness_probe_path   = var.server_readiness_probe_path
    server_liveness_probe_enable  = var.server_liveness_probe_enable
    server_liveness_probe_path    = var.server_liveness_probe_path

    service_type        = var.service_type
    node_port           = var.node_port
    service_annotations = jsonencode(var.service_annotations)

    ingress_enabled     = var.ingress_enabled
    ingress_labels      = jsonencode(var.ingress_labels)
    ingress_annotations = jsonencode(var.ingress_annotations)
    ingress_hosts       = jsonencode(var.ingress_hosts)
    ingress_tls         = jsonencode(var.ingress_tls)

    enable_auth_delegator = var.enable_auth_delegator

    ####################################
    # Storage
    ####################################
    data_storage_enable = var.raft_storage_enable
    data_storage_size   = "${var.raft_disk_size}G"

    ####################################
    # Configuration
    ####################################
    replicas         = var.server_replicas
    raft_enable      = var.raft_storage_enable
    raft_set_node_id = var.raft_set_node_id

    server_configuration = jsonencode(local.server_configuration)
  }

  server_configuration = <<EOF
ui = true

api_addr     = var.vault_api_addr
cluster_addr = var.vault_cluster_addr

listener "tcp" {
  address         = "[::]:8200"
  cluster_address = "[::]:8201"

  tls_cert_file    = "${local.tls_secret_path}/${local.tls_secret_cert_key}"
  tls_key_file     = "${local.tls_secret_path}/${local.tls_secret_key_key}"
  tls_ciper_suites = "${var.tls_cipher_suites}"

  telemetry = {
    unauthenticated_metrics_access = ${var.unauthenticated_metrics_access}
  }
}

seal "gcpckms" {
  project     = "${google_kms_key_ring.vault.project}"
  region      = "${google_kms_key_ring.vault.location}"
  key_ring    = "${google_kms_crypto_key.unseal.key_ring}"
  crypto_key  = "${google_kms_crypto_key.unseal.name}"
}

service_registration "kubernetes" {}

${var.raft_storage_enable ? local.raft_storage_config : ""}

${var.server_config}
EOF

  tls_secret_name = "${var.release_name}-tls"
  tls_secret_path = "/vault/tls"

  tls_secret_cert_key = "cert"
  tls_secret_key_key  = "key"

  tls_volume = {
    type = "secret"
    name = kubernetes_secret.tls_cert.metadata[0].name
    path = local.tls_secret_path
  }

  raft_storage_config = <<EOF
storage "raft" {
  path = "/vault/data"
}
EOF
}

resource "kubernetes_secret" "tls_cert" {
  metadata {
    name        = local.tls_secret_name
    namespace   = var.kubernetes_namespace
    labels      = var.kubernetes_labels
    annotations = var.kubernetes_annotations
  }

  type = "Opaque"

  data = {
    "${local.tls_secret_cert_key}" = var.tls_cert_pem
    "${local.tls_secret_key_key}"  = var.tls_cert_key
  }
}
