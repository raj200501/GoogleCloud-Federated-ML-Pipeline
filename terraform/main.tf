provider "google" {
  project = var.project_id
  region  = var.region
}

module "storage" {
  source = "./storage"
}

module "ai_platform" {
  source = "./ai_platform"
  depends_on = [module.storage]
}

module "cloud_run" {
  source = "./cloud_run"
  depends_on = [module.ai_platform]
}

module "iam" {
  source = "./iam"
}
