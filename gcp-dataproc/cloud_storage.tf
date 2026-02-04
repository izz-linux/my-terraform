# create GCS bucket for dataproc
resource "google_storage_bucket" "dataproc_staging_bucket" {
  name                        = "${var.bucket_name_prefix}-${var.env}-staging"
  location                    = var.region
  project                     = var.project_id
  uniform_bucket_level_access = true
  force_destroy               = true

  soft_delete_policy {
    retention_duration_seconds = 0
  }

  labels = var.labels
}

resource "google_storage_bucket" "dataproc_temp_bucket" {
  name                        = "${var.bucket_name_prefix}-${var.env}-temp"
  location                    = var.region
  project                     = var.project_id
  uniform_bucket_level_access = true
  force_destroy               = true

  soft_delete_policy {
    retention_duration_seconds = 0
  }

  labels = var.labels
}

module "dataproc_storage_buckets_iam" {
  source  = "terraform-google-modules/iam/google//modules/storage_buckets_iam"
  version = "~> 8.1.0"

  mode = "additive"

  storage_buckets = [
    google_storage_bucket.dataproc_staging_bucket.name,
    google_storage_bucket.dataproc_temp_bucket.name
  ]
      
  bindings = {
    "roles/storage.objectUser" = ["serviceAccount:${var.service_account}"]
  }
}
