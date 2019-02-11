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
HashiCorp HA only.

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

The basic configuration provided in this module only configures a default
[`listener` stanza](https://www.vaultproject.io/docs/configuration/listener/index.html) and a
[`seal` stanza](https://www.vaultproject.io/docs/configuration/seal/gcpckms.html) for auto-unsealing
via GCP KMS. Other configuration (for e.g. a
[`storage` stanza](https://www.vaultproject.io/docs/configuration/storage/index.html)) are needed.

You should refer to [Vault's documentation](https://www.vaultproject.io/docs/configuration/) on
the available options and provide them in the `vault_config` variable.

### Vault Initialisation

### Vault Unsealing

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| affinity | Affinity settings for the pods in YAML | string | `""` | no |
| annotations | Deployment annotations | map | `<map>` | no |
| chart\_name | Helm chart name to provision | string | `"incubator/vault"` | no |
| chart\_namespace | Namespace to install the chart into | string | `"kube-system"` | no |
| chart\_repository | Helm repository for the chart | string | `""` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | string | `"0.14.7"` | no |
| consul\_gossip\_secret\_key\_name | Kubernetes Secret Key holding Consul gossip key | string | `""` | no |
| consul\_image | Consul Agent image to run | string | `"consul"` | no |
| consul\_join | If set, will use this to run a Consul agent sidecar container alongside Vault. You will still need to configure Vault to use this. See https://www.consul.io/docs/agent/options.html#_join for details on this parameter | string | `""` | no |
| consul\_tag | Consul Agent image tag to run | string | `"1.4.2"` | no |
| cpu\_limit | CPU limit for pods | string | `"2000m"` | no |
| cpu\_request | CPU request for pods | string | `"500m"` | no |
| ingress\_annotations | Annotations for ingress | map | `<map>` | no |
| ingress\_enabled | Enable ingress | string | `"false"` | no |
| ingress\_hosts | Name of hosts for ingress | list | `<list>` | no |
| ingress\_labels | Labels for ingress | map | `<map>` | no |
| ingress\_tls | Ingress TLS settings | map | `<map>` | no |
| labels | Additional labels for deployment | map | `<map>` | no |
| lifecycle | YAML string of the Vault container lifecycle hooks | string | `""` | no |
| load\_balancer\_ip | Static Load balancer IP if needed | string | `""` | no |
| load\_balancer\_source\_ranges | Restrict the CIDRs that can access the load balancer | list | `<list>` | no |
| memory\_limit | Memory limit for pods | string | `"4Gi"` | no |
| memory\_request | Memory request for pods | string | `"2Gi"` | no |
| pod\_annotations | Annotations for pods | map | `<map>` | no |
| release\_name | Helm release name for Traefik | string | `"traefik"` | no |
| replica | Number of Replicas of Vault to run | string | `"3"` | no |
| secrets\_annotations | Annotations for secrets | map | `<map>` | no |
| secrets\_labels | Labels for secrets | map | `<map>` | no |
| service\_annotations | Annotations for the service | map | `<map>` | no |
| service\_cluster\_ip | Cluster Service IP if needed | string | `""` | no |
| service\_external\_port | Service external Port | string | `"8200"` | no |
| service\_name | Name of service for Vault | string | `"vault"` | no |
| service\_port | Service port | string | `"8200"` | no |
| service\_type | Service type for Vault | string | `"ClusterIP"` | no |
| tls\_cert\_key | PEM encoded private key for Vault | string | n/a | yes |
| tls\_cert\_pem | PEM encoded certificate for Vault | string | n/a | yes |
| vault\_config | Additional Vault configuration. See https://www.vaultproject.io/docs/configuration/. This is requried. The only configuration provided from this module is the listener. | map | n/a | yes |
| vault\_dev | Run Vault in dev mode | string | `"false"` | no |
| vault\_env | Extra environment variables for Vault | map | `<map>` | no |
| vault\_extra\_containers | Extra containers for Vault | map | `<map>` | no |
| vault\_extra\_volumes | Additional volumes for Vault | map | `<map>` | no |
| vault\_image | Vault Image to run | string | `"vault"` | no |
| vault\_listener\_address | Address for the Default Vault listener to bind to | string | `"[::]"` | no |
| vault\_log\_level | Log level for Vault | string | `"info"` | no |
| vault\_secret\_volumes | List of maps of custom volume mounts that are backed by Kubernetes secrets. The maps should contain the keys `secretName` and `mountPath`. | list | `<list>` | no |
| vault\_tag | Vault Image Tag to run | string | `"0.11.6"` | no |