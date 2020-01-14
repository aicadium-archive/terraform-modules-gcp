# Consul Backup

This module deploys a
[Cron Job](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) in Kubernetes to
do periodic [snapshots](https://www.consul.io/docs/commands/snapshot.html) of Consul and save it to
GCS.

## Requirements

- An existing Consul cluster to do the snapshot
- A Vault server with [Kubernetes Auth Engine](https://www.vaultproject.io/docs/auth/kubernetes.html)
    configured for the job to authenticate and a
    [GCP Secrets Engine](https://www.vaultproject.io/docs/secrets/gcp/index.html) mounted.

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| helm | n/a |
| template | n/a |
| vault | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| gcp\_bucket\_name | GCS Storage bucket name | `any` | n/a | yes |
| gcp\_bucket\_project | Project where the backup bucket is stored in | `any` | n/a | yes |
| gcp\_vault\_service\_account | Service account email for Vault for the GCP secrets engine | `any` | n/a | yes |
| vault\_address | Address for Vault | `any` | n/a | yes |
| vault\_ca | PEM encoded Vault CA certificate | `any` | n/a | yes |
| affinity | Affinity for the job | `map` | `{}` | no |
| chart\_name | Helm chart name to provision | `string` | `"consul-backup-gcs"` | no |
| chart\_repository | Helm repository for the chart | `string` | `"amoy"` | no |
| chart\_repository\_url | URL of the Chart Repository | `string` | `"https://charts.amoy.ai"` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | `string` | `""` | no |
| consul\_address | Address of Consul server | `string` | `"consul-server.service.consul:8500"` | no |
| env | Additional environment variables for the Ansible playbook | `list` | `[]` | no |
| gcp\_role\_description | Description for the custom role to allow only creator access to bucket | `string` | `"Create objects in buckets."` | no |
| gcp\_role\_id | Name of the custom role to allow only creator access to bucket | `string` | `"objectCreator"` | no |
| gcp\_role\_title | Title of the custom role to allow only creator access to bucket | `string` | `"Bucket Object Creator"` | no |
| gcp\_secrets\_path | Path to the GCP Secrets Engine in Vault | `string` | `"gcp"` | no |
| gcp\_secrets\_roleset | Name of the GCP Secrets Roleset to create | `string` | `"consul_backup"` | no |
| gcp\_vault\_role\_description | Description for the custom role to allow Vault to manage bucket IAM permissions | `string` | `"Allow Vault to manage bucket IAM permissions"` | no |
| gcp\_vault\_role\_id | Name of the custom role to allow Vault to manage bucket IAM permissions | `string` | `"vaultBucketIam"` | no |
| gcp\_vault\_role\_title | Title of the custom role to allow Vault to manage bucket IAM permissions | `string` | `"Vault Bucket IAM Manager"` | no |
| gcs\_prefix | Prefix for backup snapshots in the GCS bucket | `string` | `"backup/consul/"` | no |
| image | Docker image of the backup job | `string` | `"basisai/consul-backup-gcs"` | no |
| kubernetes\_auth\_path | Path to the Kubernetes Auth Engine | `string` | `"kubernetes"` | no |
| kubernetes\_auth\_role\_name | Name of the Kubernetes Auth Backend Role | `string` | `"consul_backup"` | no |
| namespace | Namespace to run the backup job in | `string` | `"default"` | no |
| node\_selector | Node selector for the job | `map` | `{}` | no |
| pull\_policy | Image pull policy of the backup job | `string` | `"IfNotPresent"` | no |
| release\_name | Helm release name for Vault | `string` | `"consul-backup"` | no |
| schedule | Cron schedule of job in UTC | `string` | `"0 3 * * *"` | no |
| service\_account\_name | Name of the service account for the backup job | `string` | `"consul-backup"` | no |
| tag | Docker image tag of the backup job | `string` | `"0.2.0"` | no |
| tolerations | Tolerations for the job | `list` | `[]` | no |
| ttl\_seconds | TTL of jobs in seconds. Set to an empty string to disable | `string` | `""` | no |
| vault\_policy | Name of the policy for Vault | `string` | `"consul_backup"` | no |
| vault\_ttl | TTL for the Vault Token | `string` | `"600"` | no |

## Outputs

No output.
