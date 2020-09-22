# Consul Backup

This module deploys a
[Cron Job](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) in Kubernetes to
do periodic [snapshots](https://www.consul.io/docs/commands/snapshot.html) of Consul and save it to
GCS.

## Requirements

- An existing Consul cluster to do the snapshot

Either:

- GKE cluster with Workload Identity enabled
- Service Account Key

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| helm | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| helm | >= 1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| affinity | Affinity for the job | `map` | `{}` | no |
| chart\_name | Helm chart name to provision | `string` | `"consul-backup-gcs"` | no |
| chart\_repository\_url | URL of the Chart Repository | `string` | `""` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | `string` | `""` | no |
| consul\_address | Address of Consul server | `string` | `"consul-server.service.consul:8500"` | no |
| create\_service\_account\_key | Create Service account key for use with Chart | `bool` | `false` | no |
| enable\_workload\_identity | Enable Workload Identity for GCP credentials | `bool` | `false` | no |
| env | Additional environment variables for the Ansible playbook | `list` | `[]` | no |
| gcp\_bucket\_name | GCS Storage bucket name | `any` | n/a | yes |
| gcp\_bucket\_project | Project where the backup bucket is stored in | `any` | n/a | yes |
| gcp\_role\_description | Description for the custom role to allow only creator access to bucket | `string` | `"Create objects in buckets."` | no |
| gcp\_role\_id | Name of the custom role to allow only creator access to bucket | `string` | `"objectCreator"` | no |
| gcp\_role\_title | Title of the custom role to allow only creator access to bucket | `string` | `"Bucket Object Creator"` | no |
| gcs\_prefix | Prefix for backup snapshots in the GCS bucket | `string` | `"backup/consul/"` | no |
| image | Docker image of the backup job | `string` | `"basisai/consul-backup-gcs"` | no |
| max\_history | Max history for Helm | `number` | `20` | no |
| namespace | Namespace to run the backup job in | `string` | `"default"` | no |
| node\_selector | Node selector for the job | `map` | `{}` | no |
| pull\_policy | Image pull policy of the backup job | `string` | `"IfNotPresent"` | no |
| release\_name | Helm release name | `string` | `"consul-backup"` | no |
| schedule | Cron schedule of job in UTC | `string` | `"0 3 * * *"` | no |
| service\_account\_name | Name of the service account for the backup job | `string` | `"consul-backup"` | no |
| tag | Docker image tag of the backup job | `string` | `"0.3.3"` | no |
| tls\_cacert | CA Certificate for Consul Server, if any | `any` | `null` | no |
| tls\_enabled | Enable TLS for Consul Server | `bool` | `false` | no |
| tolerations | Tolerations for the job | `list` | `[]` | no |
| ttl\_seconds | TTL of jobs in seconds. Set to an empty string to disable | `string` | `""` | no |
| workload\_identity\_gke\_project | GCP Project where the GKE cluster is located in | `string` | `""` | no |
| workload\_identity\_service\_account | Name of the GCP Service account for Workload Identity | `string` | `"consul-backup"` | no |

## Outputs

| Name | Description |
|------|-------------|
| workload\_identity\_service\_account | Email address of the workload identity linked service account |
