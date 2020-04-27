# Grafana

Deploys Grafana and some supporting services on a Kubernetes cluster running in GCP.

This module makes use of the
[`stable/grafana`](https://github.com/helm/charts/tree/master/stable/grafana) chart.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| helm | >= 1.0 |

## Providers

| Name | Version |
|------|---------|
| helm | >= 1.0 |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| affinity | Pod affinity | `map` | `{}` | no |
| annotations | Deployment annotations | `map` | `{}` | no |
| chart\_name | Helm chart name to provision | `string` | `"grafana"` | no |
| chart\_namespace | Namespace to install the chart into | `string` | `"default"` | no |
| chart\_repository | Helm repository for the chart | `string` | `"stable"` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | `string` | `""` | no |
| command | Define command to be executed at startup by grafana container | `list` | `[]` | no |
| dashboard\_providers | YAML string to configure grafana dashboard providersref: http://docs.grafana.org/administration/provisioning/#dashboards `path` must be /var/lib/grafana/dashboards/<provider\_name> | `string` | `""` | no |
| dashboards | YAML string to configure grafana dashboard to import | `string` | `""` | no |
| dashboards\_config\_maps | Reference to external ConfigMap per provider. Use provider name as key and ConfiMap name as value. YAML string | `string` | `""` | no |
| datasources | YAML string to configure grafana datasources http://docs.grafana.org/administration/provisioning/#datasources | `string` | `""` | no |
| env | Extra environment variables that will be pass onto deployment pods | `map` | `{}` | no |
| env\_from\_secret | The name of a secret in the same kubernetes namespace which contain values to be added to the environment | `string` | `""` | no |
| extra\_configmap\_mounts | Extra ConfigMap to mount into the Container | `list` | `[]` | no |
| extra\_containers | YAML string for extra containers | `string` | `""` | no |
| extra\_empty\_dir\_mounts | Extra Empty DIRs to mount into the Container | `list` | `[]` | no |
| extra\_init\_containers | Extra init containers | `list` | `[]` | no |
| extra\_secret\_mounts | Additional grafana server secret mounts | `list` | `[]` | no |
| extra\_volume\_mounts | Additional grafana server volume mounts | `list` | `[]` | no |
| fs\_group | GID for the File system group for the Grafana container | `string` | `"472"` | no |
| image | Docker Image for Grafana | `string` | `"grafana/grafana"` | no |
| image\_pull\_policy | Image Pull Policy for Grafana | `string` | `"IfNotPresent"` | no |
| ingress\_annotations | Annotations for ingress | `map` | `{}` | no |
| ingress\_enabled | Enable Ingress | `string` | `"false"` | no |
| ingress\_hosts | Hosts for ingress | `list` | `[]` | no |
| ingress\_labels | Labels for ingress | `map` | `{}` | no |
| ingress\_tls | TLS configuration for ingress | `list` | `[]` | no |
| init\_chown\_data\_enabled | Enable the Chown init container | `string` | `"true"` | no |
| init\_chown\_data\_resources | Resources for the Chown init container | `map` | `{}` | no |
| ldap\_config | String with contents for LDAP configuration in TOML | `string` | `""` | no |
| ldap\_existing\_secret | Use an existing secret for LDAP config | `string` | `""` | no |
| main\_config | Main Config file in YAML | `string` | `"paths:\n  data: /var/lib/grafana/data\n  logs: /var/log/grafana\n  plugins: /var/lib/grafana/plugins\n  provisioning: /etc/grafana/provisioning\nanalytics:\n  check_for_updates: true\nlog:\n  mode: console\ngrafana_net:\n  url: https://grafana.netn"` | no |
| max\_history | Max history for Helm | `number` | `20` | no |
| node\_selector | Node selector for Pods | `map` | `{}` | no |
| notifiers | YAML string to configure notifiers http://docs.grafana.org/administration/provisioning/#alert-notification-channels | `string` | `""` | no |
| pdb | PodDisruptionBudget for Grafana | `map` | <pre>{<br>  "minAvailable": 1<br>}</pre> | no |
| persistence\_annotations | Annotations for the PV | `map` | `{}` | no |
| persistence\_enabled | Enable PV | `string` | `"false"` | no |
| persistence\_existing\_claim | Use an existing PVC | `string` | `""` | no |
| persistence\_size | Size of the PV | `string` | `"10Gi"` | no |
| persistence\_storage\_class\_name | Storage Class name for the PV | `string` | `"default"` | no |
| plugins | List of plugins to install | `list` | `[]` | no |
| pod\_annotations | Pod annotations | `map` | `{}` | no |
| priority\_class\_name | Priority Class name for Grafana | `string` | `""` | no |
| psp\_enable | Enable PSP | `bool` | `true` | no |
| release\_name | Helm release name for Grafana | `string` | `"grafana"` | no |
| replicas | Number of replicas of Grafana to run | `number` | `1` | no |
| resources | Resources for Grafana container | `map` | `{}` | no |
| run\_as\_user | UID to run the Grafana container in | `string` | `"472"` | no |
| service\_account | Name of the Service Account for Grafana | `string` | `""` | no |
| service\_account\_annotations | Annotations for service account | `map` | `{}` | no |
| service\_annotations | Annotations for the service | `map` | `{}` | no |
| service\_labels | Labels for the service | `map` | `{}` | no |
| service\_port | Port of the service | `string` | `"80"` | no |
| service\_target\_port | Port in container to expose service | `string` | `"3000"` | no |
| service\_type | Service type | `string` | `"ClusterIP"` | no |
| smtp\_existing\_secret | Existing secret containing the SMTP credentials | `string` | `""` | no |
| smtp\_password\_key | Key in the secret containing the SMTP password | `string` | `"password"` | no |
| smtp\_user\_key | Key in the secret containing the SMTP username | `string` | `"user"` | no |
| tag | Docker Image tag for Grafana | `string` | `"6.0.2"` | no |
| tolerations | Tolerations for pods | `list` | `[]` | no |

## Outputs

No output.
