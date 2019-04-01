# Prometheus

Deploys Prometheus and some supporting services on a Kubernetes cluster running in GCP.

This module makes use of the
[`stable/prometheus`](https://github.com/helm/charts/tree/master/stable/prometheus) chart.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| alertmanager\_affinity | Affinity for alertmanager pods | map | `<map>` | no |
| alertmanager\_annotations | Annotations for Alertmanager pods | map | `<map>` | no |
| alertmanager\_base\_url | External URL which can access alertmanager | string | `"/"` | no |
| alertmanager\_config\_file\_name | The configuration file name to be loaded to alertmanager Must match the key within configuration loaded from ConfigMap/Secret | string | `"alertmanager.yml"` | no |
| alertmanager\_config\_from\_secret | The name of a secret in the same kubernetes namespace which contains the Alertmanager config Defining configFromSecret will cause templates/alertmanager-configmap.yaml to NOT generate a ConfigMap resource | string | `""` | no |
| alertmanager\_config\_map\_override\_name | ConfigMap override where fullname is {{.Release.Name}}-{{.Values.alertmanager.configMapOverrideName} Defining configMapOverrideName will cause templates/alertmanager-configmap.yaml to NOT generate a ConfigMap resource | string | `""` | no |
| alertmanager\_enable | Enable Alert manager | string | `"true"` | no |
| alertmanager\_extra\_args | Extra arguments for Alertmanager container | map | `<map>` | no |
| alertmanager\_extra\_env | Extra environment variables for Alertmanager container | map | `<map>` | no |
| alertmanager\_files | Additional ConfigMap entries for Alertmanager | map | `<map>` | no |
| alertmanager\_headless\_annotations | Annotations for alertmanager StatefulSet headless service | map | `<map>` | no |
| alertmanager\_headless\_labels | Labels for alertmanager StatefulSet headless service | map | `<map>` | no |
| alertmanager\_ingress\_annotations | Annotations for Alertmanager ingress | map | `<map>` | no |
| alertmanager\_ingress\_enabled | Enable ingress for Alertmanager | string | `"false"` | no |
| alertmanager\_ingress\_extra\_labels | Additional labels for Alertmanager ingress | map | `<map>` | no |
| alertmanager\_ingress\_hosts | List of Hosts for Alertmanager ingress | list | `<list>` | no |
| alertmanager\_ingress\_tls | TLS configurationf or Alertmanager ingress | list | `<list>` | no |
| alertmanager\_node\_selector | Node selector for alertmanager pods | map | `<map>` | no |
| alertmanager\_prefix\_url | The URL prefix at which the container can be accessed. Useful in the case the '-web.external-url' includes a slug so that the various internal URLs are still able to access as they are in the default case. | string | `""` | no |
| alertmanager\_priority\_class\_name | Priority Class Name for Alertmanager pods | string | `""` | no |
| alertmanager\_pull\_policy | Image pull policy for Alertmanager | string | `"IfNotPresent"` | no |
| alertmanager\_pv\_access\_modes | alertmanager data Persistent Volume access modes | list | `<list>` | no |
| alertmanager\_pv\_annotations | Annotations for Alertmanager PV | map | `<map>` | no |
| alertmanager\_pv\_enabled | Enable persistent volume on Alertmanager | string | `"true"` | no |
| alertmanager\_pv\_existing\_claim | Use an existing PV claim for alertmanager | string | `""` | no |
| alertmanager\_pv\_size | alertmanager data Persistent Volume size | string | `"2Gi"` | no |
| alertmanager\_replica | Number of replicas for AlertManager | string | `"1"` | no |
| alertmanager\_repository | Docker repository for Alert Manager | string | `"prom/alertmanager"` | no |
| alertmanager\_resources | Resources for alertmanager | map | `<map>` | no |
| alertmanager\_security\_context | Security context for alertmanager pods | map | `<map>` | no |
| alertmanager\_service\_annotations | Annotations for Alertmanager service | map | `<map>` | no |
| alertmanager\_service\_cluster\_ip | Cluster IP for Alertmanager Service | string | `""` | no |
| alertmanager\_service\_external\_ips | External IPs for Alertmanager service | list | `<list>` | no |
| alertmanager\_service\_labels | Labels for Alertmanager service | map | `<map>` | no |
| alertmanager\_service\_lb\_ip | Load Balancer IP for Alertmanager service | string | `""` | no |
| alertmanager\_service\_lb\_source\_ranges | List of source CIDRs allowed to access the Alertmanager LB | list | `<list>` | no |
| alertmanager\_service\_port | Service port for Alertmanager | string | `"80"` | no |
| alertmanager\_service\_type | Type of service for Alertmanager | string | `"ClusterIP"` | no |
| alertmanager\_tag | Tag for Alertmanager Docker Image | string | `"v0.16.1"` | no |
| alertmanager\_tolerations | Tolerations for Alertmanager | list | `<list>` | no |
| chart\_name | Helm chart name to provision | string | `"prometheus"` | no |
| chart\_namespace | Namespace to install the chart into | string | `"default"` | no |
| chart\_repository | Helm repository for the chart | string | `"stable"` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | string | `""` | no |
| configmap\_extra\_args | Extra arguments for ConfigMap Reload | map | `<map>` | no |
| configmap\_extra\_volumes | Extra volumes for ConfigMap Extra Volumes | list | `<list>` | no |
| configmap\_image\_repo | Docker Image repo for ConfigMap Reload | string | `"jimmidyson/configmap-reload"` | no |
| configmap\_image\_tag | Docker image tag for ConfigMap Reload | string | `"v0.2.2"` | no |
| configmap\_name | Name of the ConfigMap Reload container | string | `"configmap-reload"` | no |
| configmap\_pull\_policy | Image pull policy for ConfigMap reload | string | `"IfNotPresent"` | no |
| configmap\_resources | Resources for ConfigMap Reload pod | map | `<map>` | no |
| enable\_network\_policy | Create a NetworkPolicy resource | string | `"false"` | no |
| extra\_scrape\_configs | YAML String for extra scrape configs | string | `""` | no |
| image\_pull\_secrets | Image pull secrets, if any | map | `<map>` | no |
| init\_chown\_enabled | Enable initChownData | string | `"true"` | no |
| init\_chown\_image\_repo | Docker Image repo for initChownData | string | `"busybox"` | no |
| init\_chown\_image\_tag | Docker image tag for initChownData | string | `"latest"` | no |
| init\_chown\_name | NAme of the initChownData container | string | `"init-chown-data"` | no |
| init\_chown\_pull\_policy | Image pull policy for initChownData | string | `"IfNotPresent"` | no |
| init\_chown\_resources | Resources for initChownData | map | `<map>` | no |
| kube\_state\_metrics\_annotations | Annotations for Kube State Metrics pods | map | `<map>` | no |
| kube\_state\_metrics\_enable | Enable Kube State Metrics | string | `"true"` | no |
| kube\_state\_metrics\_extra\_args | Extra arguments for Kube State Metrics container | map | `<map>` | no |
| kube\_state\_metrics\_extra\_env | Extra environment variables for Kube State Metrics container | map | `<map>` | no |
| kube\_state\_metrics\_labels | Labels for Kube State Metrics | map | `<map>` | no |
| kube\_state\_metrics\_node\_selector | Node selector for kube_state_metrics pods | map | `<map>` | no |
| kube\_state\_metrics\_priority\_class\_name | Priority Class Name for Kube State Metrics pods | string | `""` | no |
| kube\_state\_metrics\_pull\_policy | Image pull policy for Kube State Metrics | string | `"IfNotPresent"` | no |
| kube\_state\_metrics\_replica | Number of replicas for AlertManager | string | `"1"` | no |
| kube\_state\_metrics\_repository | Docker repository for Kube State Metrics | string | `"quay.io/coreos/kube-state-metrics"` | no |
| kube\_state\_metrics\_resources | Resources for kube_state_metrics | map | `<map>` | no |
| kube\_state\_metrics\_security\_context | Security context for kube_state_metrics pods | map | `<map>` | no |
| kube\_state\_metrics\_service\_annotations | Annotations for Kube State Metrics service | map | `<map>` | no |
| kube\_state\_metrics\_service\_cluster\_ip | Cluster IP for Kube State Metrics Service | string | `"None"` | no |
| kube\_state\_metrics\_service\_external\_ips | External IPs for Kube State Metrics service | list | `<list>` | no |
| kube\_state\_metrics\_service\_labels | Labels for Kube State Metrics service | map | `<map>` | no |
| kube\_state\_metrics\_service\_lb\_ip | Load Balancer IP for Kube State Metrics service | string | `""` | no |
| kube\_state\_metrics\_service\_lb\_source\_ranges | List of source CIDRs allowed to access the Kube State Metrics LB | list | `<list>` | no |
| kube\_state\_metrics\_service\_port | Service port for Kube State Metrics | string | `"80"` | no |
| kube\_state\_metrics\_service\_type | Type of service for Kube State Metrics | string | `"ClusterIP"` | no |
| kube\_state\_metrics\_tag | Tag for Kube State Metrics Docker Image | string | `"v1.5.0"` | no |
| kube\_state\_metrics\_tolerations | Tolerations for Kube State Metrics | list | `<list>` | no |
| node\_exporter\_annotations | Annotations for Node Exporter pods | map | `<map>` | no |
| node\_exporter\_config\_map\_mounts | ConfigMap Mounts for Node Exporter | list | `<list>` | no |
| node\_exporter\_enable | Enable Node Exporter | string | `"true"` | no |
| node\_exporter\_enable\_pod\_security\_policy | Create PodSecurityPolicy for Node Exporter | string | `"false"` | no |
| node\_exporter\_extra\_args | Extra arguments for Node Exporter container | map | `<map>` | no |
| node\_exporter\_host\_network | Use the Host network namespace for Node Exporter | string | `"true"` | no |
| node\_exporter\_host\_path\_mounts | Host Path Mounts for Node Exporter | list | `<list>` | no |
| node\_exporter\_host\_pid | Use the Network PID namespace for Node Exporter | string | `"true"` | no |
| node\_exporter\_labels | Labels for Node Exporter | map | `<map>` | no |
| node\_exporter\_node\_selector | Node selector for node_exporter pods | map | `<map>` | no |
| node\_exporter\_pod\_security\_policy\_annotations | Annotations for the PodSecurityPolicy for Node Exporter | map | `<map>` | no |
| node\_exporter\_priority\_class\_name | Priority Class Name for Node Exporter pods | string | `""` | no |
| node\_exporter\_pull\_policy | Image pull policy for Node Exporter | string | `"IfNotPresent"` | no |
| node\_exporter\_replica | Number of replicas for AlertManager | string | `"1"` | no |
| node\_exporter\_repository | Docker repository for Node Exporter | string | `"prom/node-exporter"` | no |
| node\_exporter\_resources | Resources for node_exporter | map | `<map>` | no |
| node\_exporter\_security\_context | Security context for node_exporter pods | map | `<map>` | no |
| node\_exporter\_service\_annotations | Annotations for Node Exporter service | map | `<map>` | no |
| node\_exporter\_service\_cluster\_ip | Cluster IP for Node Exporter Service | string | `"None"` | no |
| node\_exporter\_service\_external\_ips | External IPs for Node Exporter service | list | `<list>` | no |
| node\_exporter\_service\_labels | Labels for Node Exporter service | map | `<map>` | no |
| node\_exporter\_service\_lb\_ip | Load Balancer IP for Node Exporter service | string | `""` | no |
| node\_exporter\_service\_lb\_source\_ranges | List of source CIDRs allowed to access the Node Exporter LB | list | `<list>` | no |
| node\_exporter\_service\_port | Service port for Node Exporter | string | `"9100"` | no |
| node\_exporter\_service\_type | Type of service for Node Exporter | string | `"ClusterIP"` | no |
| node\_exporter\_tag | Tag for Node Exporter Docker Image | string | `"v0.17.0"` | no |
| node\_exporter\_tolerations | Tolerations for Node Exporter | list | `<list>` | no |
| pushgateway\_annotations | Annotations for Pushgateway pods | map | `<map>` | no |
| pushgateway\_enable | Enable Pushgateway | string | `"true"` | no |
| pushgateway\_extra\_args | Extra arguments for Pushgateway container | map | `<map>` | no |
| pushgateway\_extra\_env | Extra environment variables for Pushgateway container | map | `<map>` | no |
| pushgateway\_ingress\_annotations | Annotations for Pushgateway ingress | map | `<map>` | no |
| pushgateway\_ingress\_enabled | Enable ingress for Pushgateway | string | `"false"` | no |
| pushgateway\_ingress\_extra\_labels | Additional labels for Pushgateway ingress | map | `<map>` | no |
| pushgateway\_ingress\_hosts | List of Hosts for Pushgateway ingress | list | `<list>` | no |
| pushgateway\_ingress\_tls | TLS configurationf or Pushgateway ingress | list | `<list>` | no |
| pushgateway\_node\_selector | Node selector for pushgateway pods | map | `<map>` | no |
| pushgateway\_priority\_class\_name | Priority Class Name for Pushgateway pods | string | `""` | no |
| pushgateway\_pull\_policy | Image pull policy for Pushgateway | string | `"IfNotPresent"` | no |
| pushgateway\_pv\_access\_modes | pushgateway data Persistent Volume access modes | list | `<list>` | no |
| pushgateway\_pv\_annotations | Annotations for Pushgateway PV | map | `<map>` | no |
| pushgateway\_pv\_enabled | Enable persistent volume on Pushgateway | string | `"true"` | no |
| pushgateway\_pv\_existing\_claim | Use an existing PV claim for pushgateway | string | `""` | no |
| pushgateway\_pv\_size | pushgateway data Persistent Volume size | string | `"2Gi"` | no |
| pushgateway\_replica | Number of replicas for AlertManager | string | `"1"` | no |
| pushgateway\_repository | Docker repository for Pushgateway | string | `"prom/pushgateway"` | no |
| pushgateway\_resources | Resources for pushgateway | map | `<map>` | no |
| pushgateway\_security\_context | Security context for pushgateway pods | map | `<map>` | no |
| pushgateway\_service\_annotations | Annotations for Pushgateway service | map | `<map>` | no |
| pushgateway\_service\_cluster\_ip | Cluster IP for Pushgateway Service | string | `""` | no |
| pushgateway\_service\_external\_ips | External IPs for Pushgateway service | list | `<list>` | no |
| pushgateway\_service\_labels | Labels for Pushgateway service | map | `<map>` | no |
| pushgateway\_service\_lb\_ip | Load Balancer IP for Pushgateway service | string | `""` | no |
| pushgateway\_service\_lb\_source\_ranges | List of source CIDRs allowed to access the Pushgateway LB | list | `<list>` | no |
| pushgateway\_service\_port | Service port for Pushgateway | string | `"9091"` | no |
| pushgateway\_service\_type | Type of service for Pushgateway | string | `"ClusterIP"` | no |
| pushgateway\_tag | Tag for Pushgateway Docker Image | string | `"v0.6.0"` | no |
| pushgateway\_tolerations | Tolerations for Pushgateway | list | `<list>` | no |
| release\_name | Helm release name for Consul | string | `"prometheus"` | no |
| server\_affinity | Affinity for server pods | map | `<map>` | no |
| server\_annotations | Annotations for server pods | map | `<map>` | no |
| server\_base\_url | External URL which can access alertmanager | string | `""` | no |
| server\_data\_retention | Prometheus data retention period (i.e 360h) | string | `""` | no |
| server\_enable\_admin\_api | Enable Admin API for server | string | `"false"` | no |
| server\_evaluation\_interval | How frequently to evaluate rules | string | `"1m"` | no |
| server\_extra\_args | Extra arguments for server container | map | `<map>` | no |
| server\_extra\_configmap\_mounts | Additional Prometheus server ConfigMap mounts | list | `<list>` | no |
| server\_extra\_env | Extra environment variables for server container | map | `<map>` | no |
| server\_extra\_host\_path\_mounts | Additional Prometheus server hostPath mounts | list | `<list>` | no |
| server\_extra\_secret\_mounts | Extra secret mounts for server | list | `<list>` | no |
| server\_extra\_volume\_mounts | Additional Prometheus server Volume mounts | list | `<list>` | no |
| server\_extra\_volumes | Additional Prometheus server Volumes | list | `<list>` | no |
| server\_files | Prometheus server ConfigMap entries | map | `<map>` | no |
| server\_ingress\_annotations | Annotations for server ingress | map | `<map>` | no |
| server\_ingress\_enabled | Enable ingress for server | string | `"false"` | no |
| server\_ingress\_extra\_labels | Additional labels for server ingress | map | `<map>` | no |
| server\_ingress\_hosts | List of Hosts for server ingress | list | `<list>` | no |
| server\_ingress\_tls | TLS configurationf or server ingress | list | `<list>` | no |
| server\_node\_selector | Node selector for server pods | map | `<map>` | no |
| server\_prefix\_url | The URL prefix at which the container can be accessed. Useful in the case the '-web.external-url' includes a slug so that the various internal URLs are still able to access as they are in the default case. | string | `""` | no |
| server\_priority\_class\_name | Priority Class Name for server pods | string | `""` | no |
| server\_pull\_policy | Image pull policy for server | string | `"IfNotPresent"` | no |
| server\_pv\_access\_modes | server data Persistent Volume access modes | list | `<list>` | no |
| server\_pv\_annotations | Annotations for server PV | map | `<map>` | no |
| server\_pv\_enabled | Enable persistent volume on server | string | `"true"` | no |
| server\_pv\_existing\_claim | Use an existing PV claim for server | string | `""` | no |
| server\_pv\_size | server data Persistent Volume size | string | `"8Gi"` | no |
| server\_replica | Number of replicas for AlertManager | string | `"1"` | no |
| server\_repository | Docker repository for server | string | `"prom/prometheus"` | no |
| server\_resources | Resources for server | map | `<map>` | no |
| server\_scrape\_interval | How frequently to scrape targets by default | string | `"1m"` | no |
| server\_scrape\_timeout | How long until a scrape request times out | string | `"10s"` | no |
| server\_security\_context | Security context for server pods | map | `<map>` | no |
| server\_service\_annotations | Annotations for server service | map | `<map>` | no |
| server\_service\_cluster\_ip | Cluster IP for server Service | string | `""` | no |
| server\_service\_external\_ips | External IPs for server service | list | `<list>` | no |
| server\_service\_labels | Labels for server service | map | `<map>` | no |
| server\_service\_lb\_ip | Load Balancer IP for server service | string | `""` | no |
| server\_service\_lb\_source\_ranges | List of source CIDRs allowed to access the server LB | list | `<list>` | no |
| server\_service\_port | Service port for server | string | `"9091"` | no |
| server\_service\_type | Type of service for server | string | `"ClusterIP"` | no |
| server\_sidecar\_containers | Sidecar containers for server | list | `<list>` | no |
| server\_skip\_tsdb\_lock | Disable TSDB locking for the server | string | `"false"` | no |
| server\_statefulset\_annotations | Annotations for server StatefulSet | map | `<map>` | no |
| server\_tag | Tag for server Docker Image | string | `"v2.8.0"` | no |
| server\_termination\_grace\_seconds | Prometheus server pod termination grace period | string | `"300"` | no |
| server\_tolerations | Tolerations for server | list | `<list>` | no |
