output "bucket_name" {
  value = module.storage.bucket_name
}

output "ai_platform_model" {
  value = module.ai_platform.model_name
}

output "cloud_run_service_url" {
  value = module.cloud_run.service_url
}
