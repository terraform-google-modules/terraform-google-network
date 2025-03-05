/*
  Description: Creates Customer GCS Buckets
  Comments:
*/

module "context_gcp_customer_backup" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.module_context.context
  name        = "backup"
  description = "${module.module_context.environment_values.kv.prefix_friendly_name} Backup"
}

resource "google_storage_bucket" "customer_backups" {
  name          = module.context_gcp_customer_backup.name
  location      = "US"
  force_destroy = false
  labels        = module.context_gcp_customer_backup.labels

  versioning {
    enabled = var.versioning
  }

  lifecycle_rule {
    condition {
      days_since_noncurrent_time = var.tier_to_archive_days
    }
    action {
      type          = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
  }

  lifecycle_rule {
    condition {
      days_since_noncurrent_time = var.delete_after_days
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age        = var.tier_to_archive_days
      with_state = "LIVE"
    }
    action {
      type          = "SetStorageClass"
      storage_class = "ARCHIVE"
    }
  }

  lifecycle_rule {
    condition {
      age        = var.delete_after_days
      with_state = "LIVE"
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}

resource "google_storage_bucket_iam_binding" "gcpbackup" {
  bucket = google_storage_bucket.customer_backups.name
  role   = "roles/storage.objectUser"
  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}
