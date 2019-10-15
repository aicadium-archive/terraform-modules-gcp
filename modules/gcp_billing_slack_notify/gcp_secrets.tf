data "google_service_account" "notifier" {
  count = local.enabled

  project    = var.billing_bigquery_project_id
  account_id = var.billing_bigquery_service_account
}

resource "google_service_account_key" "notifier" {
  count = local.enabled

  service_account_id = "${data.google_service_account.notifier[0].name}"
  private_key_type   = "TYPE_GOOGLE_CREDENTIALS_FILE"
}
