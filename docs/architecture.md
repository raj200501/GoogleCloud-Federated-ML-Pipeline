# GCPFederatedMLPipeline Architecture

## Overview

GCPFederatedMLPipeline is a Terraform project designed to deploy a scalable and automated federated machine learning pipeline on Google Cloud Platform (GCP). This project provisions necessary resources such as Google Cloud Storage buckets for data storage, AI Platform for federated model training, and Cloud Run for model deployment.

## Components

### Main
- Entry point for Terraform configuration.

### Storage
- Provisions a Google Cloud Storage bucket for data storage.

### AI Platform
- Configures AI Platform for federated ML model training.

### Cloud Run
- Deploys the trained model for serving predictions.

### IAM
- Manages IAM roles and policies to ensure proper permissions.

### Scripts
- Contains scripts for federated training and deployment.

### Models
- Contains the ML model code.

## Workflow

1. Provision infrastructure using Terraform.
2. Upload training data to Google Cloud Storage.
3. Run federated training using AI Platform.
4. Deploy the trained model to Cloud Run for serving predictions.

## Dependencies

- Terraform
- Google Cloud SDK
- Docker
- Python (for ML model and scripts)
- TensorFlow (for ML model)
