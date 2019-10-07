data "google_service_account" "notifier" {
  count = local.enabled

  account_id = "${var.billing_dataset_id}-bigquery-reader"
}

resource "google_service_account_key" "notifier" {
  count = local.enabled

  service_account_id = "${data.google_service_account.notifier[0].name}"
}
