#!/bin/bash

# Local mode fallback: skip Terraform and Cloud Run when tools are unavailable.
if [[ "${LOCAL_MODE}" == "1" ]] || ! command -v terraform >/dev/null 2>&1 || ! command -v gcloud >/dev/null 2>&1; then
  echo "Local mode enabled (missing terraform/gcloud or LOCAL_MODE=1)."
  rm -rf build_artifacts
  mkdir -p build_artifacts
  echo "Deployment skipped (local placeholder)."
  exit 0
fi

# GCP deploy path (kept separate to avoid deleting the build script directory).
if command -v terraform >/dev/null 2>&1 && command -v gcloud >/dev/null 2>&1; then
  cd terraform
  terraform init
  terraform apply -auto-approve
  gcloud run deploy ml-model-service --image gcr.io/$(gcloud config get-value project)/ml-model --platform managed --region us-central1 --allow-unauthenticated
  echo "Deployment completed."
  exit 0
fi

# Ensure the build directory is clean
rm -rf build
mkdir build

# Apply the Terraform configuration
cd terraform
terraform init
terraform apply -auto-approve

# Deploy the model docker image to Cloud Run
gcloud run deploy ml-model-service --image gcr.io/$(gcloud config get-value project)/ml-model --platform managed --region us-central1 --allow-unauthenticated

echo "Deployment completed."
