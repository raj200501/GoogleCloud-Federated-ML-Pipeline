resource "google_cloud_run_service" "ml_model_service" {
  name     = var.cloud_run_service_name
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/ml-model:latest"

        env {
          name  = "MODEL_NAME"
          value = var.model_name
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.ml_model_service.location
  project     = google_cloud_run_service.ml_model_service.project
  service     = google_cloud_run_service.ml_model_service.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"

    members = [
      "allUsers",
    ]
  }
}
