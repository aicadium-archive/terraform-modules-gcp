# Traefik

Deploys a [Traefik](https://traefik.io/)
[Ingress Controller](https://docs.traefik.io/user-guide/kubernetes/) on a Kubernetes cluster running
on GCP.

The Kubernetes cluster can be managed
(i.e. [Google Kubernetes Engine (GKE)](https://cloud.google.com/kubernetes-engine/)) or not.

## Requirements

You will need to have the following resources available:

- A Kubernetes cluster, managed by GKE, or not
- [Helm](https://helm.sh/) with Tiller running on the Cluster or you can opt to run
    [Tiller locally](https://docs.helm.sh/using_helm/#running-tiller-locally)

You will need to have the following configured on your machine:

- Credentials for GCP
- Credentials for Kubernetes configured for `kubectl`

In addition, if you would like to run more than one replica of Traefik, you have to provision a
[Consul cluster](../consul) on your Kubernetes cluster. We recommend that you use the linked
Terraform module to do so.

If you would like to enable ACME certificate, you _must_ have a Consul cluster running. In addition,
you will have to configure additional variables for the ACME challenge to work.

### GKE RBAC

If you are using GKE and have configured `kuebctl` with credentials using
`gcloud container clusters get-credentials [CLUSTER_NAME]` only, your account in Kubernetes might
not have the necessary rights to deploy this Helm chart. You can
[give](https://cloud.google.com/kubernetes-engine/docs/how-to/role-based-access-control#prerequisites_for_using_role-based_access_control)
yourself the necessary rights by running

```bash
kubectl create clusterrolebinding cluster-admin-binding \
    --clusterrole cluster-admin --user [USER_ACCOUNT]
```

where `[USER_ACCOUNT]` is your email address.

## Provisioned Resources

This module deploys a Traefik Ingress controller to Kubernetes using a
[Helm Chart](https://github.com/helm/charts/tree/master/stable/traefik).

### KV Store

In addition, this module optionally supports using the [Consul](../consul) module to provide
[KV Store](https://docs.traefik.io/user-guide/kv-config) configuration for Traefik. This allows you
to define additional resources like additional entrypoints etc.

Some features require that you have a KV store. For example, to enable additional replicas AND
support the ACME protocol, you will need to have a KV store.

### Let's Encrypt Certificates

To support [Let's Encrypt](https://letsencrypt.org/) certificates using the ACME protocol, you
__must__ use the Consul KV store. See the previous section for more information.

For more information, read the guide on [Traefik Documentation](https://docs.traefik.io/configuration/acme/).

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| access\_log\_format | Format of access logs. See https://docs.traefik.io/configuration/logs/#access-logs | string | `"json"` | no |
| access\_logs\_enabled | Enable access logs | string | `"true"` | no |
| acme\_challenge | Type of challenge to retrieve certificates. See https://docs.traefik.io/configuration/acme/#acme-challenge | string | `"httpChallenge"` | no |
| acme\_delay\_before\_check | By default, the provider will verify the TXT DNS challenge record before letting ACME verify. If acme_delay_before_check is greater than zero, this check is delayed for the configured duration in seconds. Useful when Traefik cannot resolve external DNS queries. | string | `"0"` | no |
| acme\_dns\_provider | Name of the DNS provider to perform DNS record modification for the DNS-01 challenge. See https://docs.traefik.io/configuration/acme/#dnschallenge | string | `"gcloud"` | no |
| acme\_dns\_provider\_variables | Map of environment variables for the DNS provider to perform the DNS challengt. See https://docs.traefik.io/configuration/acme/#dnschallenge | map | `<map>` | no |
| acme\_domains | List of maps of domains to generate ACME certificates for. See https://docs.traefik.io/configuration/acme/#domains for the keys required. Also see https://github.com/helm/charts/blob/15493df5ad0e38da7301bcb4979a07a0dbe5a73c/stable/traefik/values.yaml#L156-L165 for the list format required | list | `<list>` | no |
| acme\_email | Email address for ACME certificates | string | `""` | no |
| acme\_enabled | Enable ACME protocol (Let's Encrypt) | string | `"false"` | no |
| acme\_key\_type | Private key type for ACME certificates. Make sure your SSL ciphersuites supports the key type. Available values : EC256, EC384, RSA2048, RSA4096, RSA8192 | string | `"RSA4096"` | no |
| acme\_logging | Display debug log messages from the ACME client library | string | `"true"` | no |
| acme\_on\_host\_rule | Enable certificate generation on frontend Host rules. See https://docs.traefik.io/configuration/acme/#onhostrule | string | `"true"` | no |
| acme\_staging | Issue certificates from Let's Encrypt staging server | string | `"false"` | no |
| affinity | Affinity settings | map | `<map>` | no |
| chart\_name | Helm chart name to provision | string | `"stable/traefik"` | no |
| chart\_namespace | Namespace to install the chart into | string | `"kube-system"` | no |
| chart\_repository | Helm repository for the chart | string | `""` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | string | `"1.59.2"` | no |
| consul\_kv\_prefix | Consul KV configuration store prefix | string | `"traefik"` | no |
| cpu\_limit | CPU limit per Traefik pod | string | `"100m"` | no |
| cpu\_request | Initial share of CPU requested per Traefik pod | string | `"100m"` | no |
| dashboard\_auth | Dashboard authentication settings. See https://docs.traefik.io/configuration/api/#authentication | map | `<map>` | no |
| dashboard\_domain | Domain to listen on the Dashboard Ingress | string | `""` | no |
| dashboard\_enabled | Enable the Traefik Dashboard | string | `"false"` | no |
| dashboard\_host\_port\_binding | Whether to enable hostPort binding to host for dashboard. | string | `"false"` | no |
| dashboard\_ingress\_annotations | Annotations for the Traefik dashboard Ingress definition, specified as a map | map | `<map>` | no |
| dashboard\_ingress\_labels | Labels for the Traefik dashboard Ingress definition, specified as a map | map | `<map>` | no |
| dashboard\_ingress\_tls | TLS settings for the Traefik dashboard Ingress definition | map | `<map>` | no |
| dashboard\_recent\_errors | Number of recent errors to show in the ‘Health’ tab | string | `"10"` | no |
| dashboard\_service\_annotations | Annotations for the Traefik dashboard Service definition, specified as a map | map | `<map>` | no |
| dashboard\_service\_type | Service type for the dashboard service | string | `"ClusterIP"` | no |
| datadog\_address | Addess of the Datadog host | string | `""` | no |
| datadog\_enabled | Enable pushing metrics to Datadog | string | `"false"` | no |
| datadog\_push\_interval | How often to push metrics to Datadog. | string | `"10s"` | no |
| debug | Operator Traefik in Debug mode. | string | `"false"` | no |
| deployment\_strategy | Deployment strategy for the Traefik pods. See https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#strategy | map | `<map>` | no |
| enable\_consul\_kv | Enable KV Store with Consul | string | `"false"` | no |
| external\_traffic\_policy | Route traffic to Traefik using node-local or cluster-wide endpoints. See https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip | string | `"Cluster"` | no |
| http\_host\_port\_binding | Whether to enable hostPort binding to host for http. | string | `"false"` | no |
| https\_host\_port\_binding | Whether to enable hostPort binding to host for https. | string | `"false"` | no |
| ingress\_class | Value of kubernetes.io/ingress.class annotation to watch - must start with traefik if set | string | `"traefik"` | no |
| internal\_static\_ip | Whether the static IP to reserve is internal | string | `"false"` | no |
| internal\_static\_ip\_subnetwork | The URL of the subnetwork in which to reserve the internal static address | string | `""` | no |
| label\_selector | Valid Kubernetes ingress label selector to watch | string | `""` | no |
| lb\_source\_range | List of CIDR allowed to access the Network Load balancer. This setting is enforced by GCP Network LB | list | `<list>` | no |
| memory\_limit | Memory limit per Traefik pod | string | `"30Mi"` | no |
| memory\_request | Initial share of memory requested per Traefik pod | string | `"20Mi"` | no |
| namespaces | List of Kubernetes namespaces to watch | list | `<list>` | no |
| node\_port\_http | Desired nodePort for service of type NodePort used for http requests. Blank will assign a dynamic port | string | `"80"` | no |
| node\_port\_https | Desired nodePort for service of type NodePort used for https requests. Blank will assign a dynamic port | string | `"443"` | no |
| node\_selector | Node labels for pod assignment | map | `<map>` | no |
| pod\_annotations | Annotations for the Traefik pod definition | map | `<map>` | no |
| pod\_disruption\_budget | Map describing the Pod Disruption Budget. See https://kubernetes.io/docs/tasks/run-application/configure-pdb/ | map | `<map>` | no |
| pod\_labels | Labels for the Traefik pod definition | map | `<map>` | no |
| pod\_priority\_class | Pod priority class name. See https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ | string | `""` | no |
| prometheus\_enabled | Enable the Prometheus metrics server | string | `"false"` | no |
| prometheus\_restrict\_access | Whether to limit access to the metrics port (8080) to the dashboard service. When false, it is accessible on the main Traefik service as well. | string | `"true"` | no |
| rbac\_enabled | Whether to enable RBAC with a specific cluster role and binding for Traefik | string | `"true"` | no |
| release\_name | Helm release name for Traefik | string | `"traefik"` | no |
| replicas | Number of replias to run | string | `"1"` | no |
| root\_ca | List of Root CAs for Traefik to trust when encountering backends. Put the contents into the variable | list | `<list>` | no |
| service\_annotations | Annotations for the Traefik Service definition, specified as a map | map | `<map>` | no |
| service\_labels | Additional labels for the Traefik Service definition, specified as a map. | map | `<map>` | no |
| service\_type | Kubernetes service type to run as. `NodePort` or `LoadBalancer`. | string | `"LoadBalancer"` | no |
| ssl\_ciphersuites | List of SSL ciphersuites to use. Leave empty for default. This must match the type of key you use for your certificates | list | `<list>` | no |
| ssl\_enabled | Enable SSL endpoin. You will either need to use the Let's Encrypt ACME certificates or provide your own. Otherwise, Traefik will serve an expired self-signed certificatre | string | `"true"` | no |
| ssl\_enforced | Enforce SSL by performing a redirect from the non SSL endpoint | string | `"true"` | no |
| ssl\_min\_version | Minimum version of SSL to use. See https://docs.traefik.io/configuration/entrypoints/#specify-minimum-tls-version | string | `"VersionTLS12"` | no |
| ssl\_permanent\_redirect | When redirecting from the non SSL endpoint to the SSL endpoint, use a permanent redirect (301) instead of a temporary one (302) | string | `"true"` | no |
| startup\_arguments | List of additional startup arguments for the Traefik pods | list | `<list>` | no |
| static\_ip\_name | Name of the Static IP resource to deploy for the Network LB | string | n/a | yes |
| statsd\_address | Addess of the statsd host | string | `""` | no |
| statsd\_enabled | Enable pushing metrics to statsd | string | `"false"` | no |
| statsd\_push\_interval | How often to push metrics to statsd. | string | `"10s"` | no |
| tolerations | List of map of tolerations for Traefik Pods. See https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/ | list | `<list>` | no |
| tracing\_backend | One of `jaegar`, `zipkin` or `datadog` | string | `""` | no |
| tracing\_enabled | Whether to enable request tracing | string | `"false"` | no |
| tracing\_service\_name | Service name to be used in tracing backend | string | `"traefik"` | no |
| tracing\_settings | Map of settings for the tracing backend. See `templates/values.yaml` for information | map | `<map>` | no |
| traefik\_image\_name | Docker Image of Traefik to run | string | `"traefik"` | no |
| traefik\_image\_tag | Docker image tag of Traefik to run | string | `"1.7-alpine"` | no |
| traefik\_log\_format | Log format for Traefik. See https://docs.traefik.io/configuration/logs/#traefik-logs | string | `"json"` | no |
| whitelist\_source\_range | List of CIDRs allowed to access the Traefik Load balancer. This setting is enforced by Traefik. | list | `<list>` | no |

## Outputs

| Name | Description |
|------|-------------|
| static\_ip | Address of the Traefik Load balancer static IP |
| values | Rendered Values file |
