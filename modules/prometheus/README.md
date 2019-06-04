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
| alertmanager\_files | Additional ConfigMap entries for Alertmanager in YAML string | string | `"alertmanager.yml:\n  global: {}\n    # slack_api_url: ''\n\n  receivers:\n    - name: default-receiver\n      # slack_configs:\n      #  - channel: '@you'\n      #    send_resolved: true\n\n  route:\n    group_wait: 10s\n    group_interval: 5m\n    receiver: default-receiver\n    repeat_interval: 3h\n"` | no |
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
| alertmanager\_security\_context | Security context for alertmanager pods defined as a map which will be serialized to JSON.   Due to limitations with Terraform 0.11 and below, integers are serialized as strings in JSON and   this will not work for fields like `runAsUser`. Specify a JSON string with   `alertmanager_security_context_json` instead | map | `<map>` | no |
| alertmanager\_security\_context\_json | JSON string for security context for alertmanager pods | string | `""` | no |
| alertmanager\_service\_account | Name of the service account for AlertManager. Defaults to component's fully qualified name. | string | `""` | no |
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
| init\_chown\_name | Name of the initChownData container | string | `"init-chown-data"` | no |
| init\_chown\_pull\_policy | Image pull policy for initChownData | string | `"IfNotPresent"` | no |
| init\_chown\_resources | Resources for initChownData | map | `<map>` | no |
| kube\_state\_metrics\_annotations | Annotations for Kube State Metrics pods | map | `<map>` | no |
| kube\_state\_metrics\_enable | Enable Kube State Metrics | string | `"true"` | no |
| kube\_state\_metrics\_extra\_args | Extra arguments for Kube State Metrics container | map | `<map>` | no |
| kube\_state\_metrics\_extra\_env | Extra environment variables for Kube State Metrics container | map | `<map>` | no |
| kube\_state\_metrics\_labels | Labels for Kube State Metrics | map | `<map>` | no |
| kube\_state\_metrics\_node\_selector | Node selector for Kube State Metrics pods | map | `<map>` | no |
| kube\_state\_metrics\_priority\_class\_name | Priority Class Name for Kube State Metrics pods | string | `""` | no |
| kube\_state\_metrics\_pull\_policy | Image pull policy for Kube State Metrics | string | `"IfNotPresent"` | no |
| kube\_state\_metrics\_replica | Number of replicas for Kube State Metrics | string | `"1"` | no |
| kube\_state\_metrics\_repository | Docker repository for Kube State Metrics | string | `"quay.io/coreos/kube-state-metrics"` | no |
| kube\_state\_metrics\_resources | Resources for Kube State Metrics | map | `<map>` | no |
| kube\_state\_metrics\_security\_context | Security context for kube_state_metrics pods defined as a map which will be serialized to JSON.   Due to limitations with Terraform 0.11 and below, integers are serialized as strings in JSON and   this will not work for fields like `runAsUser`. Specify a JSON string with   `kube_state_metrics_security_context_json` instead | map | `<map>` | no |
| kube\_state\_metrics\_security\_context\_json | JSON string for security context for kube_state_metrics pods | string | `""` | no |
| kube\_state\_metrics\_service\_account | Name of the service account for kubeStateMetrics. Defaults to component's fully qualified name. | string | `""` | no |
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
| node\_exporter\_replica | Number of replicas for Node Exporter | string | `"1"` | no |
| node\_exporter\_repository | Docker repository for Node Exporter | string | `"prom/node-exporter"` | no |
| node\_exporter\_resources | Resources for node_exporter | map | `<map>` | no |
| node\_exporter\_security\_context | Security context for node_exporter pods defined as a map which will be serialized to JSON.   Due to limitations with Terraform 0.11 and below, integers are serialized as strings in JSON and   this will not work for fields like `runAsUser`. Specify a JSON string with   `node_exporter_security_context_json` instead | map | `<map>` | no |
| node\_exporter\_security\_context\_json | JSON string for security context for node_exporter pods | string | `""` | no |
| node\_exporter\_service\_account | Name of the service account for nodeExporter. Defaults to component's fully qualified name. | string | `""` | no |
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
| pushgateway\_replica | Number of replicas for pushgateway | string | `"1"` | no |
| pushgateway\_repository | Docker repository for Pushgateway | string | `"prom/pushgateway"` | no |
| pushgateway\_resources | Resources for pushgateway | map | `<map>` | no |
| pushgateway\_security\_context | Security context for pushgateway pods defined as a map which will be serialized to JSON.   Due to limitations with Terraform 0.11 and below, integers are serialized as strings in JSON and   this will not work for fields like `runAsUser`. Specify a JSON string with   `pushgateway_security_context_json` instead | map | `<map>` | no |
| pushgateway\_security\_context\_json | JSON string for security context for pushgateway pods | string | `""` | no |
| pushgateway\_service\_account | Name of the service account for pushgateway. Defaults to component's fully qualified name. | string | `""` | no |
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
| release\_name | Helm release name for Prometheus | string | `"prometheus"` | no |
| server\_affinity | Affinity for server pods | map | `<map>` | no |
| server\_alerts | Prometheus server alerts entries in YAML | string | `"## Alerts configuration\n## Ref: https://prometheus.io/docs/prometheus/latest/configuration/alerting_rules/\nalerts: {}\n# groups:\n#   - name: Instances\n#     rules:\n#       - alert: InstanceDown\n#         expr: up == 0\n#         for: 5m\n#         labels:\n#           severity: page\n#         annotations:\n#           description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 5 minutes.'\n#           summary: 'Instance {{ $labels.instance }} down'\n"` | no |
| server\_annotations | Annotations for server pods | map | `<map>` | no |
| server\_base\_url | External URL which can access alertmanager | string | `""` | no |
| server\_config | Prometheus server config file in YAML | string | `"prometheus.yml:\n  rule_files:\n    - /etc/config/rules\n    - /etc/config/alerts\n\n  scrape_configs:\n    - job_name: prometheus\n      static_configs:\n        - targets:\n          - localhost:9090\n\n    # A scrape configuration for running Prometheus on a Kubernetes cluster.\n    # This uses separate scrape configs for cluster components (i.e. API server, node)\n    # and services to allow each to use different authentication configs.\n    #\n    # Kubernetes labels will be added as Prometheus labels on metrics via the\n    # `labelmap` relabeling action.\n\n    # Scrape config for API servers.\n    #\n    # Kubernetes exposes API servers as endpoints to the default/kubernetes\n    # service so this uses `endpoints` role and uses relabelling to only keep\n    # the endpoints associated with the default/kubernetes service using the\n    # default named port `https`. This works for single API server deployments as\n    # well as HA API server deployments.\n    - job_name: 'kubernetes-apiservers'\n\n      kubernetes_sd_configs:\n        - role: endpoints\n\n      # Default to scraping over https. If required, just disable this or change to\n      # `http`.\n      scheme: https\n\n      # This TLS \u0026 bearer token file config is used to connect to the actual scrape\n      # endpoints for cluster components. This is separate to discovery auth\n      # configuration because discovery \u0026 scraping are two separate concerns in\n      # Prometheus. The discovery auth config is automatic if Prometheus runs inside\n      # the cluster. Otherwise, more config options have to be provided within the\n      # \u003ckubernetes_sd_config\u003e.\n      tls_config:\n        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt\n        # If your node certificates are self-signed or use a different CA to the\n        # master CA, then disable certificate verification below. Note that\n        # certificate verification is an integral part of a secure infrastructure\n        # so this should only be disabled in a controlled environment. You can\n        # disable certificate verification by uncommenting the line below.\n        #\n        insecure_skip_verify: true\n      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token\n\n      # Keep only the default/kubernetes service endpoints for the https port. This\n      # will add targets for each API server which Kubernetes adds an endpoint to\n      # the default/kubernetes service.\n      relabel_configs:\n        - source_labels: [__meta_kubernetes_namespace, __meta_kubernetes_service_name, __meta_kubernetes_endpoint_port_name]\n          action: keep\n          regex: default;kubernetes;https\n\n    - job_name: 'kubernetes-nodes'\n\n      # Default to scraping over https. If required, just disable this or change to\n      # `http`.\n      scheme: https\n\n      # This TLS \u0026 bearer token file config is used to connect to the actual scrape\n      # endpoints for cluster components. This is separate to discovery auth\n      # configuration because discovery \u0026 scraping are two separate concerns in\n      # Prometheus. The discovery auth config is automatic if Prometheus runs inside\n      # the cluster. Otherwise, more config options have to be provided within the\n      # \u003ckubernetes_sd_config\u003e.\n      tls_config:\n        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt\n        # If your node certificates are self-signed or use a different CA to the\n        # master CA, then disable certificate verification below. Note that\n        # certificate verification is an integral part of a secure infrastructure\n        # so this should only be disabled in a controlled environment. You can\n        # disable certificate verification by uncommenting the line below.\n        #\n        insecure_skip_verify: true\n      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token\n\n      kubernetes_sd_configs:\n        - role: node\n\n      relabel_configs:\n        - action: labelmap\n          regex: __meta_kubernetes_node_label_(.+)\n        - target_label: __address__\n          replacement: kubernetes.default.svc:443\n        - source_labels: [__meta_kubernetes_node_name]\n          regex: (.+)\n          target_label: __metrics_path__\n          replacement: /api/v1/nodes/$1/proxy/metrics\n\n\n    - job_name: 'kubernetes-nodes-cadvisor'\n\n      # Default to scraping over https. If required, just disable this or change to\n      # `http`.\n      scheme: https\n\n      # This TLS \u0026 bearer token file config is used to connect to the actual scrape\n      # endpoints for cluster components. This is separate to discovery auth\n      # configuration because discovery \u0026 scraping are two separate concerns in\n      # Prometheus. The discovery auth config is automatic if Prometheus runs inside\n      # the cluster. Otherwise, more config options have to be provided within the\n      # \u003ckubernetes_sd_config\u003e.\n      tls_config:\n        ca_file: /var/run/secrets/kubernetes.io/serviceaccount/ca.crt\n        # If your node certificates are self-signed or use a different CA to the\n        # master CA, then disable certificate verification below. Note that\n        # certificate verification is an integral part of a secure infrastructure\n        # so this should only be disabled in a controlled environment. You can\n        # disable certificate verification by uncommenting the line below.\n        #\n        insecure_skip_verify: true\n      bearer_token_file: /var/run/secrets/kubernetes.io/serviceaccount/token\n\n      kubernetes_sd_configs:\n        - role: node\n\n      # This configuration will work only on kubelet 1.7.3+\n      # As the scrape endpoints for cAdvisor have changed\n      # if you are using older version you need to change the replacement to\n      # replacement: /api/v1/nodes/$1:4194/proxy/metrics\n      # more info here https://github.com/coreos/prometheus-operator/issues/633\n      relabel_configs:\n        - action: labelmap\n          regex: __meta_kubernetes_node_label_(.+)\n        - target_label: __address__\n          replacement: kubernetes.default.svc:443\n        - source_labels: [__meta_kubernetes_node_name]\n          regex: (.+)\n          target_label: __metrics_path__\n          replacement: /api/v1/nodes/$1/proxy/metrics/cadvisor\n\n    # Scrape config for service endpoints.\n    #\n    # The relabeling allows the actual service scrape endpoint to be configured\n    # via the following annotations:\n    #\n    # * `prometheus.io/scrape`: Only scrape services that have a value of `true`\n    # * `prometheus.io/scheme`: If the metrics endpoint is secured then you will need\n    # to set this to `https` \u0026 most likely set the `tls_config` of the scrape config.\n    # * `prometheus.io/path`: If the metrics path is not `/metrics` override this.\n    # * `prometheus.io/port`: If the metrics are exposed on a different port to the\n    # service then set this appropriately.\n    # * `prometheus.io/param-\u003cNAME\u003e`: Sets the HTTP URL parameters \u003cNAME\u003e to the value\n    # of the annotation\n    - job_name: 'kubernetes-service-endpoints'\n\n      kubernetes_sd_configs:\n        - role: endpoints\n\n      relabel_configs:\n        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scrape]\n          action: keep\n          regex: true\n        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_scheme]\n          action: replace\n          target_label: __scheme__\n          regex: (https?)\n        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_path]\n          action: replace\n          target_label: __metrics_path__\n          regex: (.+)\n        - source_labels: [__address__, __meta_kubernetes_service_annotation_prometheus_io_port]\n          action: replace\n          target_label: __address__\n          regex: ([^:]+)(?::\\d+)?;(\\d+)\n          replacement: $1:$2\n        - action: labelmap\n          regex: __meta_kubernetes_service_annotation_prometheus_io_param_(.+)\n          replacement: __param_$1\n        - action: labelmap\n          regex: __meta_kubernetes_service_label_(.+)\n        - source_labels: [__meta_kubernetes_namespace]\n          action: replace\n          target_label: kubernetes_namespace\n        - source_labels: [__meta_kubernetes_service_name]\n          action: replace\n          target_label: kubernetes_name\n        - source_labels: [__meta_kubernetes_pod_node_name]\n          action: replace\n          target_label: kubernetes_node\n        - action: labelmap\n          regex: __meta_kubernetes_pod_(.+)\n          replacement: pod_$1\n        - action: labelmap\n          regex: __meta_kubernetes_service_(.+)\n          replacement: service_$1\n\n    - job_name: 'prometheus-pushgateway'\n      honor_labels: true\n\n      kubernetes_sd_configs:\n        - role: service\n\n      relabel_configs:\n        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_probe]\n          action: keep\n          regex: pushgateway\n\n    # Example scrape config for probing services via the Blackbox Exporter.\n    #\n    # The relabeling allows the actual service scrape endpoint to be configured\n    # via the following annotations:\n    #\n    # * `prometheus.io/probe`: Only probe services that have a value of `true`\n    - job_name: 'kubernetes-services'\n\n      metrics_path: /probe\n      params:\n        module: [http_2xx]\n\n      kubernetes_sd_configs:\n        - role: service\n\n      relabel_configs:\n        - source_labels: [__meta_kubernetes_service_annotation_prometheus_io_probe]\n          action: keep\n          regex: true\n        - source_labels: [__address__]\n          target_label: __param_target\n        - target_label: __address__\n          replacement: blackbox\n        - source_labels: [__param_target]\n          target_label: instance\n        - action: labelmap\n          regex: __meta_kubernetes_service_label_(.+)\n        - source_labels: [__meta_kubernetes_namespace]\n          target_label: kubernetes_namespace\n        - source_labels: [__meta_kubernetes_service_name]\n          target_label: kubernetes_name\n\n    # Example scrape config for pods\n    #\n    # The relabeling allows the actual pod scrape endpoint to be configured via the\n    # following annotations:\n    #\n    # * `prometheus.io/scrape`: Only scrape pods that have a value of `true`\n    # * `prometheus.io/path`: If the metrics path is not `/metrics` override this.\n    # * `prometheus.io/port`: Scrape the pod on the indicated port instead of the default of `9102`.\n    # * `prometheus.io/param-\u003cNAME\u003e`: Sets the HTTP URL parameters \u003cNAME\u003e to the value\n    # of the annotation\n    - job_name: 'kubernetes-pods'\n\n      kubernetes_sd_configs:\n        - role: pod\n\n      relabel_configs:\n        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_scrape]\n          action: keep\n          regex: true\n        - source_labels: [__meta_kubernetes_pod_annotation_prometheus_io_path]\n          action: replace\n          target_label: __metrics_path__\n          regex: (.+)\n        - source_labels: [__address__, __meta_kubernetes_pod_annotation_prometheus_io_port]\n          action: replace\n          regex: ([^:]+)(?::\\d+)?;(\\d+)\n          replacement: $1:$2\n          target_label: __address__\n        - action: labelmap\n          regex: __meta_kubernetes_pod_annotation_prometheus_io_param_(.+)\n          replacement: __param_$1\n        - action: labelmap\n          regex: __meta_kubernetes_pod_label_(.+)\n        - source_labels: [__meta_kubernetes_namespace]\n          action: replace\n          target_label: kubernetes_namespace\n        - source_labels: [__meta_kubernetes_pod_name]\n          action: replace\n          target_label: kubernetes_pod_name\n"` | no |
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
| server\_headless\_annotations | Annotations for server StatefulSet headless service | map | `<map>` | no |
| server\_headless\_labels | Labels for server StatefulSet headless service | map | `<map>` | no |
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
| server\_replica | Number of replicas for server | string | `"1"` | no |
| server\_repository | Docker repository for server | string | `"prom/prometheus"` | no |
| server\_resources | Resources for server | map | `<map>` | no |
| server\_rules | Prometheus server rules entries in YAML | string | `"rules: {}\n"` | no |
| server\_scrape\_interval | How frequently to scrape targets by default | string | `"1m"` | no |
| server\_scrape\_timeout | How long until a scrape request times out | string | `"10s"` | no |
| server\_security\_context | Security context for server pods defined as a map which will be serialized to JSON.   Due to limitations with Terraform 0.11 and below, integers are serialized as strings in JSON and   this will not work for fields like `runAsUser`. Specify a JSON string with   `server_security_context_json` instead | map | `<map>` | no |
| server\_security\_context\_json | JSON string for security context for server pods | string | `""` | no |
| server\_service\_account | Name of the service account for server. Defaults to component's fully qualified name. | string | `""` | no |
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
| server\_tag | Tag for server Docker Image | string | `"v2.8.1"` | no |
| server\_termination\_grace\_seconds | Prometheus server pod termination grace period | string | `"300"` | no |
| server\_tolerations | Tolerations for server | list | `<list>` | no |
