# Cloud SQL Backup

This module deploys a
[Cron Job](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/) in Kubernetes to
do periodic
[on-demand backups](https://cloud.google.com/sql/docs/postgres/backup-recovery/backing-up#on-demand)
of Cloud SQL databases.

## Requirements

- An Cloud SQL Database
- A Vault server with [Kubernetes Auth Engine](https://www.vaultproject.io/docs/auth/kubernetes.html)
    configured for the job to authenticate and a
    [GCP Secrets Engine](https://www.vaultproject.io/docs/secrets/gcp/index.html) mounted.
