#!/bin/bash

# This script initiates federated training across multiple nodes

# Define variables
PROJECT_ID=$(gcloud config get-value project)
REGION=us-central1
BUCKET_NAME=ml-pipeline-bucket

# Initialize federated training
echo "Starting federated training..."

# Download data
gsutil cp gs://${BUCKET_NAME}/data/training-data.csv ./training-data.csv

# Run federated training script
python3 models/model.py --data_path=./training-data.csv --output_path=./model_output

# Upload the model artifacts to GCS
gsutil cp ./model_output/model.h5 gs://${BUCKET_NAME}/model/

echo "Federated training completed and model uploaded to GCS."
