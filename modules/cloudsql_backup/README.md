# Cloud SQL Backup

This module deploys a
[Cron Job](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) in Kubernetes to
do periodic
[on-demand backups](https://cloud.google.com/sql/docs/postgres/backup-recovery/backing-up#on-demand)
of Cloud SQL databases.

## Requirements

- An Cloud SQL Database
- A Vault server with [Kubernetes Auth Engine](https://www.vaultproject.io/docs/auth/kubernetes.html)
    configured for the job to authenticate and a
    [GCP Secrets Engine](https://www.vaultproject.io/docs/secrets/gcp/index.html) mounted.

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| helm | >= 1.0 |
| template | n/a |
| vault | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| affinity | Affinity for the job | `map` | `{}` | no |
| chart\_name | Helm chart name to provision | `string` | `"gcloud-cron"` | no |
| chart\_repository | Helm repository for the chart | `string` | `"amoy"` | no |
| chart\_repository\_url | URL of the Chart Repository | `string` | `"https://charts.amoy.ai"` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | `string` | `""` | no |
| cloudsql\_instance | Name of the Cloud SQL Instance | `any` | n/a | yes |
| cloudsql\_project | Project where the CloudSQL instance is in | `any` | n/a | yes |
| enable\_vault\_agent | Enable using Vault agent for retrieving GCP credentials | `bool` | `false` | no |
| enable\_workload\_identity | Enable Workload Identity for GCP credentials | `bool` | `false` | no |
| entrypoint | Override Entrypoint of the container | `string` | `""` | no |
| env | Additional environment variables for the Gcloud Job | `list` | `[]` | no |
| gcp\_role\_description | Description for the custom role to allow only creator access to bucket | `string` | `"Create backup runs for Cloud SQL instances."` | no |
| gcp\_role\_id | Name of the custom role to allow only creator access to bucket | `string` | `"cloudSqlBackup"` | no |
| gcp\_role\_title | Title of the custom role to allow only creator access to bucket | `string` | `"Cloud SQL Backup Creator"` | no |
| gcp\_secrets\_path | Path to the GCP Secrets Engine in Vault | `string` | `"gcp"` | no |
| gcp\_secrets\_roleset | Name of the GCP Secrets Roleset to create | `string` | `"cloudsql_backup"` | no |
| gcp\_vault\_service\_account | Service account email for Vault for the GCP secrets engine | `string` | `""` | no |
| image | Docker image of the backup job | `string` | `"google/cloud-sdk"` | no |
| kubernetes\_auth\_path | Path to the Kubernetes Auth Engine | `string` | `"kubernetes"` | no |
| kubernetes\_auth\_role\_name | Name of the Kubernetes Auth Backend Role | `string` | `"cloudsql_backup"` | no |
| max\_history | Max history for Helm | `number` | `20` | no |
| namespace | Namespace to run the backup job in | `string` | `"default"` | no |
| node\_selector | Node selector for the job | `map` | `{}` | no |
| pull\_policy | Image pull policy of the backup job | `string` | `"IfNotPresent"` | no |
| release\_name | Helm release name for Vault | `string` | `"cloudsql-backup"` | no |
| schedule | Cron schedule of job in UTC | `string` | `"0 3 * * *"` | no |
| service\_account\_name | Name of the service account for the backup job | `string` | `"cloudsql-backup"` | no |
| tag | Docker image tag of the backup job | `string` | `"251.0.0-alpine"` | no |
| tolerations | Tolerations for the job | `list` | `[]` | no |
| ttl\_seconds | TTL of jobs in seconds. Set to an empty string to disable | `string` | `""` | no |
| vault\_address | Address for Vault | `string` | `""` | no |
| vault\_ca | PEM encoded Vault CA certificate | `string` | `""` | no |
| vault\_policy | Name of the policy for Vault | `string` | `"cloudsql_backup"` | no |
| vault\_ttl | TTL for the Vault Token | `string` | `"600"` | no |
| workload\_identity\_gke\_project | GCP Project where the GKE cluster is located in | `string` | `""` | no |
| workload\_identity\_service\_account | Name of the GCP Service account for Workload Identity | `string` | `"cloudsql-backup"` | no |

## Outputs

| Name | Description |
|------|-------------|
| vault\_roleset\_service\_account | Email address of the GCP Secrets Engine Service account |
| workload\_identity\_service\_account | Email address of the workload identity linked service account |
