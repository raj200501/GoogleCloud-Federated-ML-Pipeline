resource "google_storage_bucket" "ml_pipeline_bucket" {
  name     = var.bucket_name
  location = var.region

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age = 30
    }
  }
}
