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

The chart includes:

- something

In addiition, this module provisions:

- A static IP address for use with the external (internet) network load balancer
- A static IP address for use with the internal (intranet) network load balancer

## Usage

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| affinity | Affinity settings | string | n/a | yes |
| chart\_name | Helm chart name to provision | string | `"stable/traefik"` | no |
| chart\_repository | Helm repository for the chart | string | `""` | no |
| chart\_version | Version of Chart to install. Set to empty to install the latest version | string | `"1.59.2"` | no |
| cpu\_limit | CPU limit per Traefik pod | string | `"100m"` | no |
| cpu\_request | Initial share of CPU requested per Traefik pod | string | `"100m"` | no |
| external\_cidr | List of CIDR allowed to access the external endpoint | list | `<list>` | no |
| external\_static\_ip\_name | Name of the Static IP resource to deploy for the external (internet) facing Network LB | string | n/a | yes |
| external\_traffic\_policy | Route traffic to Traefik using node-local or cluster-wide endpoints. See https://kubernetes.io/docs/tasks/access-application-cluster/create-external-load-balancer/#preserving-the-client-source-ip | string | `"Cluster"` | no |
| internal\_static\_ip\_name | Name of the Static IP resource to deploy for the internal (intranet) facing Network LB. Set to an empty string to disable. | string | `""` | no |
| internal\_static\_ip\_subnetwork | The URL of the subnetwork in which to reserve the internal static address | string | n/a | yes |
| memory\_limit | Memory limit per Traefik pod | string | `"30Mi"` | no |
| memory\_request | Initial share of memory requested per Traefik pod | string | `"20Mi"` | no |
| node\_selector | Node labels for pod assignment | map | `<map>` | no |
| pod\_annotations | Annotations for the Traefik pod definition | map | `<map>` | no |
| pod\_labels | Labels for the Traefik pod definition | map | `<map>` | no |
| rbac\_enabled | Whether to enable RBAC with a specific cluster role and binding for Traefik | string | `"true"` | no |
| release\_name | Helm release name for Traefik | string | `"traefik"` | no |
| replicas | Number of replias to run | string | `"1"` | no |
| service\_annotations | Annotations for the Traefik Service definition, specified as a map | map | `<map>` | no |
| service\_labels | Additional labels for the Traefik Service definition, specified as a map. | map | `<map>` | no |
| service\_type | Kubernetes service type to run as. `NodePort` or `LoadBalancer`. | string | `"LoadBalancer"` | no |
| traefik\_image\_name | Docker Image of Traefik to run | string | `"traefik"` | no |
| traefik\_image\_tag | Docker image tag of Traefik to run | string | `"1.7-alpine"` | no |
