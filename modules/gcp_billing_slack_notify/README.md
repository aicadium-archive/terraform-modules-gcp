# GCP Billing Slack Notify

This module deploys a
[Cron Job](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) in Kubernetes to
do periodic notifications of GCP spending via Slack.

## Requirements

- Export billing data to BigQuery: https://cloud.google.com/billing/docs/how-to/export-data-bigquery
- Slack Incoming Webhook: https://api.slack.com/incoming-webhooks
