# Consul Backup

This module deploys a
[Cron Job](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) in Kubernetes to
do periodic [snapshots](https://www.consul.io/docs/commands/snapshot.html) of Consul and save it to
GCS.

## Requirements

- An existing Consul cluster to do the snapshot
- A Vault server with [Kubernetes Auth Engine](https://www.vaultproject.io/docs/auth/kubernetes.html)
    configured for the job to authenticate and a
    [GCP Secrets Engine](https://www.vaultproject.io/docs/secrets/gcp/index.html) mounted.
