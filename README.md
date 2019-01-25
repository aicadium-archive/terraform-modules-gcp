# Terraform Modules for GCP

Collection of opinionated Terraform Modules for use on GCP. Some modules are standalone while others
might depend on others in this repository or otherwise.

## Submodules

This repository contains some vendored submodules in the `vendor` directory. Make sure you clone
this repository with

```bash
git clone --recurse-submodules https://github.com/basisai/terraform-modules-gcp.git
```

## Modules

### Consul

Deploys a [Consul](https://www.consul.io/) cluster on Kubernetes cluster running on GCP.

### Traefik

Deploys a [Traefik](https://traefik.io/)
[Ingress Controller](https://docs.traefik.io/user-guide/kubernetes/) on a Kubernetes cluster running
on GCP.

## License

This repository is [licensed](LICENSE) under the Apache 2.0 license.
