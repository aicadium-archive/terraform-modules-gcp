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

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| google-beta | n/a |
| helm | n/a |
| kubernetes | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| kms\_location | Location of the KMS key ring. Must be in the same location as your storage bucket | `any` | n/a | yes |
| kms\_project | Project ID to create the keyring in | `any` | n/a | yes |
| storage\_bucket\_name | Name of the Storage Bucket to store Vault's state | `any` | n/a | yes |
| storage\_bucket\_project | Project ID to create the storage bucket under | `any` | n/a | yes |
| tls\_cert\_key | PEM encoded private key for Vault | `any` | n/a | yes |
| tls\_cert\_pem | PEM encoded certificate for Vault | `any` | n/a | yes |
| vault\_config | Additional Vault configuration. See https://www.vaultproject.io/docs/configuration/. This is requried. The only configuration provided from this module is the listener. | `any` | n/a | yes |
| affinity | Affinity settings for the pods. Can be templated via Helm. The default has Anti affinity for other Vault pods. | `map` | <code><pre>{<br>  "podAntiAffinity": {<br>    "requiredDuringSchedulingIgnoredDuringExecution": [<br>      {<br>        "labelSelector": {<br>          "matchLabels": {<br>            "app": "{{ template \"vault.name\" . }}",<br>            "release": "{{ .Release.Name }}"<br>          }<br>        },<br>        "topologyKey": "kubernetes.io/hostname"<br>      }<br>    ]<br>  }<br>}<br></pre></code> | no |
| annotations | Deployment annotations | `map` | `{}` | no |
| chart\_name | Helm chart name to provision | `string` | `"incubator/vault"` | no |
| chart\_namespace | Namespace to install the chart into | `string` | `"kube-system"` | no |
| chart\_repository | Helm repository for the chart | `string` | `""` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | `string` | `"0.16.0"` | no |
| consul\_gossip\_secret\_key\_name | Kubernetes Secret Key holding Consul gossip key | `string` | `""` | no |
| consul\_image | Consul Agent image to run | `string` | `"consul"` | no |
| consul\_join | If set, will use this to run a Consul agent sidecar container alongside Vault. You will still need to configure Vault to use this. See https://www.consul.io/docs/agent/options.html#\_join for details on this parameter | `string` | `""` | no |
| consul\_tag | Consul Agent image tag to run | `string` | `"1.4.2"` | no |
| container\_lifecycle | YAML string of the Vault container lifecycle hooks | `string` | `""` | no |
| cpu\_limit | CPU limit for pods | `string` | `""` | no |
| cpu\_request | CPU request for pods | `string` | `"500m"` | no |
| fullname\_override | Full name of resources | `string` | `"vault"` | no |
| gke\_cluster | Cluster to create node pool for | `string` | `"\u003cREQUIRED if gke_pool_create is true\u003e"` | no |
| gke\_disk\_type | Disk type for the nodes | `string` | `"pd-standard"` | no |
| gke\_labels | Labels for the GKE nodes | `map` | `{}` | no |
| gke\_machine\_type | Machine type for the GKE nodes. Make sure this matches the resources you are requesting | `string` | `"n1-standard-2"` | no |
| gke\_metadata | Metadata for the GKE nodes | `map` | `{}` | no |
| gke\_node\_count | Initial Node count. If regional, remember to divide the desired node count by the number of zones | `number` | `3` | no |
| gke\_node\_size\_gb | Disk size for the nodes in GB | `string` | `"20"` | no |
| gke\_node\_upgrade\_settings | Surge upgrade settings as per https://cloud.google.com/kubernetes-engine/docs/concepts/cluster-upgrades#surge | `object({ max_surge = number, max_unavailable = number })` | <code><pre>{<br>  "max_surge": 1,<br>  "max_unavailable": 0<br>}<br></pre></code> | no |
| gke\_node\_upgrade\_settings\_enabled | Enable/disable gke node pool surge upgrade settings | `bool` | `false` | no |
| gke\_pool\_create | Whether to create the GKE node pool or not | `bool` | `false` | no |
| gke\_pool\_location | Location for the node pool | `string` | `"\u003cREQUIRED if gke_pool_create is true\u003e"` | no |
| gke\_pool\_name | Name of the GKE Pool name to create | `string` | `"vault"` | no |
| gke\_project | Project ID where the GKE cluster lives in | `string` | `"\u003cREQUIRED if gke_pool_create is true\u003e"` | no |
| gke\_tags | Network tags for the GKE nodes | `list` | `[]` | no |
| gke\_taints | List of map of taints for GKE nodes. It is highly recommended you do set this alongside the pods toleration. See https://www.terraform.io/docs/providers/google/r/container\_cluster.html#key for the keys and the README for more information | `list` | `[]` | no |
| ingress\_annotations | Annotations for ingress | `map` | `{}` | no |
| ingress\_enabled | Enable ingress | `string` | `"false"` | no |
| ingress\_hosts | Name of hosts for ingress | `list` | `[]` | no |
| ingress\_labels | Labels for ingress | `map` | `{}` | no |
| ingress\_tls | Ingress TLS settings | `map` | `{}` | no |
| key\_ring\_name | Name of the Keyring to create. | `string` | `"vault"` | no |
| labels | Additional labels for deployment | `map` | `{}` | no |
| load\_balancer\_ip | Static Load balancer IP if needed | `string` | `""` | no |
| load\_balancer\_source\_ranges | Restrict the CIDRs that can access the load balancer | `list` | `[]` | no |
| memory\_limit | Memory limit for pods | `string` | `"4Gi"` | no |
| memory\_request | Memory request for pods | `string` | `""` | no |
| min\_ready\_seconds | Minimum number of seconds that newly created replicas must be ready without any containers crashing | `string` | `"0"` | no |
| node\_selector | Node selectors for pods | `map` | `{}` | no |
| pod\_annotations | Annotations for pods | `map` | `{}` | no |
| pod\_api\_address | Set the `VAULT_API_ADDR` environment variable to the Pod IP Address. This is the address (full URL) to advertise to other Vault servers in the cluster for client redirection. See https://www.vaultproject.io/docs/configuration/#api\_addr. If this is `true`, then `vault_api_addr` will have no effect. | `string` | `"false"` | no |
| pod\_priority\_class | Pod priority class name. See https://kubernetes.io/docs/concepts/configuration/pod-priority-preemption/ | `string` | `""` | no |
| release\_name | Helm release name for Vault | `string` | `"vault"` | no |
| replica | Number of Replicas of Vault to run | `number` | `3` | no |
| secrets\_annotations | Annotations for secrets | `map` | `{}` | no |
| secrets\_labels | Labels for secrets | `map` | `{}` | no |
| service\_annotations | Annotations for the service | `map` | `{}` | no |
| service\_cluster\_ip | Cluster Service IP if needed | `string` | `""` | no |
| service\_external\_port | Service external Port | `number` | `8200` | no |
| service\_name | Name of service for Vault | `string` | `"vault"` | no |
| service\_port | Service port | `number` | `8200` | no |
| service\_type | Service type for Vault | `string` | `"ClusterIP"` | no |
| storage\_bucket\_class | Storage class of the bucket. See https://cloud.google.com/storage/docs/storage-classes | `string` | `"REGIONAL"` | no |
| storage\_bucket\_labels | Set of labels for the storage bucket | `map` | <code><pre>{<br>  "terraform": "true"<br>}<br></pre></code> | no |
| storage\_bucket\_location | Location of the storage bucket. Defaults to the provider's region if empty. This must be in the same location as your KMS key. | `string` | `""` | no |
| storage\_ha\_enabled | Use the GCS bucket to provide HA for Vault. Set to "false" if you are using alternative HA storage like Consul | `string` | `"true"` | no |
| storage\_key\_name | Name of the Vault storage key | `string` | `"storage"` | no |
| storage\_key\_rotation\_period | Rotation period of the Vault storage key. Defaults to 6 months | `string` | `"15780000s"` | no |
| timeout | Time in seconds to wait for any individual kubernetes operation. | `number` | `600` | no |
| tls\_cipher\_suites | Specifies the list of supported ciphersuites as a comma-separated-list. Make sure this matches the type of key of the TLS certificate you are using. See https://golang.org/src/crypto/tls/cipher\_suites.go | `string` | `"TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256,TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384,TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA,TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA,TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA,TLS_RSA_WITH_AES_128_GCM_SHA256,TLS_RSA_WITH_AES_256_GCM_SHA384,TLS_RSA_WITH_AES_128_CBC_SHA,TLS_RSA_WITH_AES_256_CBC_SHA"` | no |
| tolerations | List of maps of tolerations for the pod. It is recommend you use this to run Vault on dedicated nodes. See the README | `list` | `[]` | no |
| unauthenticated\_metrics\_access | If set to true, allows unauthenticated access to the /v1/sys/metrics endpoint. | `bool` | `false` | no |
| unseal\_key\_name | Name of the Vault unseal key | `string` | `"unseal"` | no |
| unseal\_key\_rotation\_period | Rotation period of the Vault unseal key. Defaults to 6 months | `string` | `"15780000s"` | no |
| vault\_api\_addr | This is the address (full URL) to advertise to other Vault servers in the cluster for client redirection. See https://www.vaultproject.io/docs/configuration/#api\_addr. | `string` | `"false"` | no |
| vault\_dev | Run Vault in dev mode | `string` | `"false"` | no |
| vault\_env | Extra environment variables for Vault | `list` | `[]` | no |
| vault\_extra\_containers | Extra containers for Vault | `list` | `[]` | no |
| vault\_extra\_volume\_mounts | Additional Volume Mounts for Vault | `list` | `[]` | no |
| vault\_extra\_volumes | Additional volumes for Vault | `list` | `[]` | no |
| vault\_image | Vault Image to run | `string` | `"vault"` | no |
| vault\_listener\_address | Address for the Default Vault listener to bind to | `string` | `"[::]"` | no |
| vault\_log\_level | Log level for Vault | `string` | `"info"` | no |
| vault\_node\_service\_account | Service Account for Vault Node Pools if Workload Identity is enabled | `string` | `"vault-gke-node"` | no |
| vault\_secret\_volumes | List of maps of custom volume mounts that are backed by Kubernetes secrets. The maps should contain the keys `secretName` and `mountPath`. | `list` | `[]` | no |
| vault\_server\_location\_description | Location of Vault server to put in description strings of resources | `string` | `""` | no |
| vault\_server\_service\_account | Service Account name for the Vault Server | `string` | `"vault-server"` | no |
| vault\_service\_account | Required if you did not create a node pool. This should be the service account that is used by the nodes to run Vault workload. They will be given additional permissions to use the keys for auto unseal and to write to the storage bucket | `string` | `"\u003cREQUIRED if not creating GKE node pool\u003e"` | no |
| vault\_tag | Vault Image Tag to run | `string` | `"1.0.2"` | no |
| workload\_identity\_enable | Enable Workload Identity on the GKE Node Pool. For more information, see https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity | `bool` | `false` | no |
| workload\_identity\_project | Project to Create the Service Accoutn for Vault Pods  if Workload Identity is enabled. Defaults to the GKE project. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| key\_ring\_self\_link | Self-link of the KMS Keyring created for Vault |
| node\_pool\_service\_account | Email ID of the GKE node pool service account if created |
| release\_name | Release name of the Helm chart |
| vault\_server\_service\_account | Email ID of the Vault server Service Account if created |
