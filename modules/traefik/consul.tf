# Additional Configuration not provided by the Helm Chart. Requires Consul KV store
resource "consul_keys" "acme" {
  count = "${local.consul_enabled && local.acme_enabled ? 1 : 0}"

  key {
    path   = "${var.consul_kv_prefix}/acme/storage"
    value  = "${var.consul_kv_prefix}/acme/account"
    delete = true
  }

  key {
    path   = "${var.consul_kv_prefix}/acme/keytype"
    value  = "${var.acme_key_type}"
    delete = true
  }
}
