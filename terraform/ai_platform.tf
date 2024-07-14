resource "google_ai_platform_model" "ml_model" {
  name = var.model_name
}

resource "google_ai_platform_version" "ml_model_version" {
  name          = "v1"
  deployment_uri = "gs://${google_storage_bucket.ml_pipeline_bucket.name}/model"
  model         = google_ai_platform_model.ml_model.name

  runtime_version = "2.3"
  python_version  = "3.7"
}
