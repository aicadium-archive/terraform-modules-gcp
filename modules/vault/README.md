# Vault

Deploys a [Vault](https://www.vaultproject.io/) cluster on Kubernetes running on GCP.

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

### Configuration

### Operational Considerations

It might be useful to refer to Hashicorp's
[guide](https://learn.hashicorp.com/vault/operations/production-hardening) on how to harden your
Vault cluster.

The sections below would detail additional considerations that are specific to the setup
that this module provides.

#### Storage

You should consider using either using
[Google Cloud Storage](https://www.vaultproject.io/docs/configuration/storage/google-cloud-storage.html)
or [Google Cloud Spanner](https://www.vaultproject.io/docs/configuration/storage/google-cloud-spanner.html)
for storage.

#### High Availability Mode (HA)

You should enable [HA](https://www.vaultproject.io/docs/concepts/ha.html) for Vault. This can be
accomplished by several means. We recommend that you use a [Consul](https://www.consul.io/))
cluster, running on the Kubernetes Cluster or not. If you use any of the storage recommended above,
they already come with HA support.

#### TLS

You need to generate a set of self-signed certificates for Vault to communicate. Refer to the
[CA Guide](../../utils/ca) for more information.

#### Kubernetes

You should run Vault in a separate
[namespace](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
and provision all the Kubernetes resources in this namespace. Then, you can make use of
[RBAC](https://kubernetes.io/docs/reference/access-authn-authz/rbac/) to control access to resources
in this namespace.

You should consider running Vault on a separate nodes from the rest of your workload. You should
also make use of
[taints and tolerations](https://kubernetes.io/docs/concepts/configuration/taint-and-toleration/) to
make sure that these nodes run Vault exclusively.

In addition, you should configure various
[Admission Controllers](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/)
to control access to pod tolerations using
[`PodTolerationRestriction`](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#podtolerationrestriction)
and nodes from modifying their own taints using
[`NodeRestriction`](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noderestriction).

### Vault Initialisation

### Vault Unsealing
