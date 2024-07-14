# GCPFederatedMLPipeline API Reference

## Modules

### Storage

- `google_storage_bucket`: Provisions a Google Cloud Storage bucket.

### AI Platform

- `google_ai_platform_model`: Configures AI Platform for federated ML model training.
- `google_ai_platform_version`: Manages versions of the AI Platform model.

### Cloud Run

- `google_cloud_run_service`: Deploys the trained model for serving predictions.
- `google_cloud_run_service_iam_policy`: Manages IAM policies for the Cloud Run service.

### IAM

- `google_project_iam_member`: Manages IAM roles and permissions.
- `google_service_account`: Creates a service account for the ML pipeline.

## Scripts

### federated_training.sh

- Initiates federated training across multiple nodes.

### build.sh

- Builds the model docker image.

### deploy.sh

- Applies the Terraform configuration and deploys the model docker image to Cloud Run.
