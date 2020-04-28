resource "google_compute_disk" "raft" {
  provider = google-beta
  count    = var.raft_storage_enable && ! var.raft_disk_regional ? var.server_replicas : 0

  name = "${var.raft_persistent_disks_prefix}${count.index}"
  type = var.raft_disk_type
  size = var.raft_disk_size

  zone = element(coalescelist(var.raft_disk_zones, data.google_compute_zones.available.names), count.index)

  description = "Vault server data disks replica ${count.index}"

  labels  = var.labels
  project = var.project_id

  disk_encryption_key {
    kms_key_self_link = google_kms_crypto_key.storage.self_link
  }
}

resource "google_compute_region_disk" "raft" {
  provider = google-beta
  count    = var.raft_storage_enable && var.raft_disk_regional ? var.server_replicas : 0

  name = "${var.raft_persistent_disks_prefix}${count.index}"
  type = var.raft_disk_type
  size = var.raft_disk_size

  region = var.region
  replica_zones = coalescelist(
    element(var.raft_replica_zones, count.index),
    [element(data.google_compute_zones.available.names, count.index), element(data.google_compute_zones.available.names, count.index + 1)]
  )

  description = "Vault server data disks replica ${count.index}"

  labels  = var.labels
  project = var.project_id

  disk_encryption_key {
    kms_key_name = google_kms_crypto_key.storage.self_link
  }
}

resource "google_compute_resource_policy" "raft_backup" {
  provider = google-beta
  count    = var.raft_storage_enable ? 1 : 0

  name    = var.raft_backup_policy
  region  = var.region
  project = var.project_id

  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = var.raft_snapshot_days_in_cycle
        start_time    = var.raft_snapshot_start_time
      }
    }

    retention_policy {
      max_retention_days    = var.raft_backup_max_retention_days
      on_source_disk_delete = "KEEP_AUTO_SNAPSHOTS"
    }

    snapshot_properties {
      labels            = var.labels
      storage_locations = [var.region]
      guest_flush       = false
    }
  }
}

resource "google_compute_disk_resource_policy_attachment" "raft_backup" {
  provider = google-beta
  count    = var.raft_storage_enable && ! var.raft_disk_regional ? var.server_replicas : 0

  name = google_compute_resource_policy.raft_backup[0].name
  disk = google_compute_disk.raft[count.index].name
  zone = google_compute_disk.raft[count.index].zone

  project = var.project_id
}

resource "google_compute_region_disk_resource_policy_attachment" "raft_backup" {
  provider = google-beta
  count    = var.raft_storage_enable && var.raft_disk_regional ? var.server_replicas : 0

  name   = google_compute_resource_policy.raft_backup[0].name
  disk   = google_compute_region_disk.raft[count.index].name
  region = google_compute_region_disk.raft[count.index].region

  project = var.project_id
}

resource "kubernetes_persistent_volume" "raft" {
  count = var.raft_storage_enable ? var.server_replicas : 0

  metadata {
    name = "data-${local.fullname}-${count.index}"

    annotations = var.kubernetes_annotations
    labels      = var.kubernetes_labels
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    capacity = {
      storage = "${var.raft_disk_size}G"
    }

    persistent_volume_source {
      gce_persistent_disk {
        pd_name = var.raft_disk_regional ? google_compute_region_disk.raft[count.index].name : google_compute_disk.raft[count.index].name
        fs_type = "ext4"
      }
    }
  }
}

# resource "kubernetes_persistent_volume_claim" "raft" {
#   count = var.raft_storage_enable ? var.server_replicas : 0

#   metadata {
#     name = "data-${local.fullname}-${count.index}"

#     annotations = var.kubernetes_annotations
#     labels      = var.kubernetes_labels

#     namespace = var.kubernetes_namespace
#   }

#   spec {
#     access_modes = ["ReadWriteOnce"]
#     volume_name  = kubernetes_persistent_volume.raft[count.index].metadata[0].name

#     # It's necessary to specify "" as the storageClassName
#     # so that the default storage class won't be used, see
#     # https://kubernetes.io/docs/concepts/storage/persistent-volumes/#class-1
#     storage_class_name = ""

#     resources {
#       requests = {
#         storage = "${var.raft_disk_size}G"
#       }
#     }
#   }
# }

# Using a Helm Chart in the meantime
# cf. https://github.com/terraform-providers/terraform-provider-kubernetes/pull/590
resource "helm_release" "raft_pvc" {
  count      = var.raft_storage_enable ? 1 : 0
  depends_on = [kubernetes_persistent_volume.raft]

  name      = "data-${local.fullname}"
  chart     = var.chart_name
  namespace = var.kubernetes_namespace

  timeout = var.timeout

  max_history = var.max_history

  values = [
    yamlencode(
      {
        namePrefix  = "data-${local.fullname}-"
        replicas    = var.server_replicas
        labels      = var.kubernetes_labels
        annotations = var.kubernetes_annotations

        spec = {
          accessModes = ["ReadWriteOnce"]
          resources = {
            requests = {
              storage = "${var.raft_disk_size}G"
            }
          }
          storageClassName = ""
        }
      }
    )
  ]
}
