# Vault

Deploys a [Vault](https://www.vaultproject.io/) cluster on Kubernetes running on GCP in an
opinionated fashion.

This module makes use of the this
[incubator Helm Chart](https://github.com/helm/charts/tree/master/incubator/vault).

You should be familiar with various [concepts](https://www.vaultproject.io/docs/concepts/) for Vault
first before continuing

## Requirements

You will need to have the following resources available:

- A Kubernetes cluster, managed by GKE, or not
- [Helm](https://helm.sh/) with Tiller running on the Cluster or you can opt to run
    [Tiller locally](https://docs.helm.sh/using_helm/#running-tiller-locally)

You will need to have the following configured on your machine:

- Credentials for GCP
- Credentials for Kubernetes configured for `kubectl`

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

## Usage

This module uses the [Helm Chart](https://github.com/helm/charts/tree/master/incubator/vault) for
Vault to deploy Vault running on a Kubernetes Cluster.

In addition, for (opinionated) operational reasons, this module additionally provisions the
following additional resources:

- A Google Cloud Storage (GCS) Bucket for storing Vault State and to provide High Availability
- A Google KMS key for auto unsealing Vault
- (Optional) A separate GKE Node pool purely for running Vault

This module makes use of both the `google` and the `google-beta` provider. See the documentation on
GCP [provider versions](https://www.terraform.io/docs/providers/google/provider_versions.html).

### Operational Considerations

It might be useful to refer to Hashicorp's
[guide](https://learn.hashicorp.com/vault/operations/production-hardening) on how to harden your
Vault cluster.

The sections below would detail additional considerations that are specific to the setup
that this module provides.

#### Separate GCP Project

The most granular permissions that you can assign to most GCP resources is at the project level.
Therefore, you should provision the resources for Vault, wherever possible, in their own separate
GCP project. You could use Google's
[Project Factory module](https://github.com/terraform-google-modules/terraform-google-project-factory)
to Terraform a new project specifically for Vault.

#### High Availability Mode (HA)

HA is enabled "for free" by our use of the GCS bucket for storage. Optionally, you can choose to use
a [Consul](https://www.consul.io/)) cluster, running on the Kubernetes Cluster or not for
HashiCorp HA only. If you choose to do so, remember to set `storage_ha_enabled` to `"false"`.

#### TLS

You need to generate a set of self-signed certificates for Vault to communicate. Refer to the
[CA Guide](../../utils/ca) for more information.

Remember to encrypt the private key before checking it into your repository. You can use the
[`google_kms_secret`](https://www.terraform.io/docs/providers/google/d/google_kms_secret.html) data
source to decrypt during apply time.

You must provide the unencrypted PEM encoded certificate and key in the variables `tls_cert_pem`
and `tls_cert_key` respectively.

#### Kubernetes

You should run Vault in a separate
[namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
and provision all the Kubernetes resources in this namespace. Then, you can make use of
[RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) to control access to resources
in this namespace.

You should also consider running Vault on a separate nodes from the rest of your workload. You
should also make use of
[taints and tolerations](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) to
make sure that these nodes run Vault exclusively.

In addition, you should configure various
[Admission Controllers](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/)
to control access to pod tolerations using
[`PodTolerationRestriction`](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#podtolerationrestriction)
and nodes from modifying their own taints using
[`NodeRestriction`](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noderestriction).

### Vault Configuration

The basic configuration provided in this module configures the following:

- [`listener` stanza](https://www.vaultproject.io/docs/configuration/listener/index.html)
- [`seal` stanza](https://www.vaultproject.io/docs/configuration/seal/gcpckms.html) for auto-unsealing
    via GCP KMS.
- [`storage` stanza](https://www.vaultproject.io/docs/configuration/storage/index.html) using the
    GCS bucket.

Not all required parameters are automatically configured. For example, the
[`api_addr`](https://www.vaultproject.io/docs/configuration/#api_addr) field is not automatically
configured.

You should refer to [Vault's documentation](https://www.vaultproject.io/docs/configuration/) on
the additional options available and provide them in the `vault_config` variable.

### Vault Initialisation

The first time you deploy Vault, you need to initialise Vault. You can do this by `kubectl exec`
into one of the pods.

Assuming you have deployed the Helm chart using the release name `vault` in the `default` namespace,
you can find the list of pods using

```bash
kubectl get pods --namespace default --selector=release=vault
```

Choose one of the pods and `exec` into the pod:

```bash
kubectl exec --namespace default -it vault-xxxx-xxxx -c vault sh

# Once inside the pod, we can run
vault operator init -tls-skip-verify
```

**Make sure you take note of the recovery keys and the intial root token!**

If you lose the recovery key, you will lose all your data.

You should then `exec` into the remaining pods and force a restart of the container

```bash
kill -15 1
```

You will only need to do this for the first time.

### Vault Unsealing

Vault is set up to [auto unseal](https://www.vaultproject.io/docs/concepts/seal.html#auto-unseal)
using the KMS key provisioned by this module. You will generally not have to worry about manually
unsealing Vault if the nodes have access to the keys.

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
| chart\_name | Helm chart name to provision | string | `"https://github.com/basisai/charts/releases/download/traefik-env/traefik-1.59.3.tgz"` | no |
| chart\_namespace | Namespace to install the chart into | string | `"kube-system"` | no |
| chart\_repository | Helm repository for the chart | string | `""` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | string | `""` | no |
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
| secret\_files | KV Map of secret files and their contents | map | `<map>` | no |
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
