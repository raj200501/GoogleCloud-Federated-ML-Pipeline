#!/bin/bash

# This script initiates federated training across multiple nodes
set -e

# Local mode fallback: run training using bundled sample data when GCP tools are unavailable.
# Set LOCAL_MODE=1 to force this behavior.
if [[ "${LOCAL_MODE}" == "1" ]] || ! command -v gcloud >/dev/null 2>&1 || ! command -v gsutil >/dev/null 2>&1; then
  echo "Local mode enabled (missing gcloud/gsutil or LOCAL_MODE=1)."
  LOCAL_DATA_PATH="./data/training-data.csv"
  OUTPUT_PATH="./model_output"
  mkdir -p "${OUTPUT_PATH}"
  if [[ ! -f "${LOCAL_DATA_PATH}" ]]; then
    echo "Sample data not found at ${LOCAL_DATA_PATH}."
    exit 1
  fi
  echo "Starting local training using ${LOCAL_DATA_PATH}..."
  PYTHONPATH=. python3 models/model.py --data_path="${LOCAL_DATA_PATH}" --output_path="${OUTPUT_PATH}"
  echo "Local training completed. Model saved to ${OUTPUT_PATH}/model.h5"
  exit 0
fi

# Define variables
PROJECT_ID=$(gcloud config get-value project)
REGION=us-central1
BUCKET_NAME=ml-pipeline-bucket

# Initialize federated training
echo "Starting federated training..."

# Download data
gsutil cp gs://${BUCKET_NAME}/data/training-data.csv ./training-data.csv

# Run federated training script
export PYTHONPATH=.
python3 models/model.py --data_path=./training-data.csv --output_path=./model_output

# Upload the model artifacts to GCS
gsutil cp ./model_output/model.h5 gs://${BUCKET_NAME}/model/

echo "Federated training completed and model uploaded to GCS."
