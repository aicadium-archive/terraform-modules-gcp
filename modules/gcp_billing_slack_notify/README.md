# GCP Billing Slack Notify

This module deploys a
[Cron Job](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) in Kubernetes to
do periodic notifications of GCP spending via Slack.

## Requirements

- Export billing data to BigQuery: https://cloud.google.com/billing/docs/how-to/export-data-bigquery
- Slack Incoming Webhook: https://api.slack.com/incoming-webhooks

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| helm | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| billing\_bigquery\_project\_id | GCP Project ID where the Bigquery dataset resides | `any` | n/a | yes |
| billing\_bigquery\_service\_account | GCP service account with permissions to access the bigquery dataset | `any` | n/a | yes |
| gcp\_billing\_account\_id | GCP billing account ID that manages projects' spendings | `any` | n/a | yes |
| gcp\_project\_ids | GCP project IDs to calculate spending | `list(string)` | n/a | yes |
| slack\_webhook | Slack webhook to send notifications to Slack | `any` | n/a | yes |
| affinity | Affinity for the job | `map` | `{}` | no |
| annotations | Annotations for the job | `map` | `{}` | no |
| chart\_name | Helm chart name to provision | `string` | `"gcp-billing-slack-notify"` | no |
| chart\_repository | Helm repository for the chart | `string` | `"amoy"` | no |
| chart\_repository\_url | URL of the Chart Repository | `string` | `"https://charts.amoy.ai"` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | `string` | `"0.1.1"` | no |
| enabled | Enable/disable chart | `bool` | `true` | no |
| image | Docker image of the backup job | `string` | `"basisai/gcp-billing-slack-notify"` | no |
| labels | Labels for the job | `map` | `{}` | no |
| namespace | Namespace to run the job in | `string` | `"core"` | no |
| node\_selector | Node selector for the job | `map` | `{}` | no |
| pull\_policy | Image pull policy of the job | `string` | `"IfNotPresent"` | no |
| release\_name | Helm release name | `string` | `"gcp-billing-slack-notify"` | no |
| resources | Resources used by the job | `map` | <code><pre>{<br>  "limits": {<br>    "cpu": "200m",<br>    "memory": "256Mi"<br>  },<br>  "requests": {<br>    "cpu": "100m",<br>    "memory": "256Mi"<br>  }<br>}<br></pre></code> | no |
| schedule | Cron schedule of job in UTC | `string` | `"0 3 * * *"` | no |
| tag | Docker image tag of the job | `string` | `"0.1.1"` | no |
| tolerations | Tolerations for the job | `list` | `[]` | no |
| ttl\_seconds | TTL of jobs in seconds. Set to an empty string to disable | `number` | `86400` | no |

## Outputs

No output.
