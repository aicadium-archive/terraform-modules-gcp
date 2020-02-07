# cert-manager

This module deploys a
[cert-manager](https://cert-manager.io/docs) in Kubernetes to
do help manage the creation and renewal of certificates such as Let's Encrypt certs.

## Providers

| Name | Version |
|------|---------|
| google | n/a |
| helm | >= 1.0 |
| null | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| acme\_email | Email address to register for ACME account | `any` | n/a | yes |
| acme\_environment | ACME environment. Either production or staging. | `string` | `"staging"` | no |
| additional\_values | Additional Values for the Helm Chart. (for e.g. values for the underlying dependent chart) | `list` | `[]` | no |
| certificates | Certificates to generate | `list(object({ common_name = string, san = list(string), renew_before = string }))` | `[]` | no |
| certmanager\_chart\_version | Version of Certmanager helm chart | `string` | `"1.0.1"` | no |
| certmanager\_crd\_version | Version of the CustomResourceDefinition resources for Certmanager. See https://cert-manager.netlify.com/docs/installation/kubernetes/#steps | `string` | `"0.12"` | no |
| certmanager\_enabled | Enable/disable Certmanager | `bool` | `true` | no |
| certmanager\_service\_account | Name of the service account for Certmanager | `string` | `"certmanager"` | no |
| kube\_context | Kubernetes context | `any` | n/a | yes |
| kube\_namespace | Namespace to run Certmanager | `string` | `"core"` | no |
| max\_history | Max history for Helm | `number` | `20` | no |
| project\_id | Project ID to deploy the cluster to | `any` | n/a | yes |

## Outputs

No output.
