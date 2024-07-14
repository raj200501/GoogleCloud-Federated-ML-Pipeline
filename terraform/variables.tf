variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region for GCP resources"
  type        = string
  default     = "us-central1"
}

variable "bucket_name" {
  description = "The name of the Google Cloud Storage bucket"
  type        = string
  default     = "ml-pipeline-bucket"
}

variable "model_name" {
  description = "The name of the AI Platform model"
  type        = string
  default     = "ml-model"
}

variable "cloud_run_service_name" {
  description = "The name of the Cloud Run service"
  type        = string
  default     = "ml-model-service"
}
