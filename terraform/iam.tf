resource "google_project_iam_member" "ml_pipeline_service_account" {
  project = var.project_id
  role    = "roles/storage.objectAdmin"
  member  = "serviceAccount:${google_service_account.ml_pipeline_service_account.email}"
}

resource "google_service_account" "ml_pipeline_service_account" {
  account_id   = "ml-pipeline-sa"
  display_name = "ML Pipeline Service Account"
}
