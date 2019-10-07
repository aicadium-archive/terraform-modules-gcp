data "google_service_account" "notifier" {
  account_id = "${var.billing_dataset_id}-bigquery-reader"
}

resource "google_service_account_key" "notifier" {
  service_account_id = "${data.google_service_account.notifier.name}"
}
