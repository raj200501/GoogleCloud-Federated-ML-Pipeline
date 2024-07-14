#!/bin/bash

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
