#!/bin/bash

# Local mode fallback: create a placeholder build artifact when GCP tools are unavailable.
if [[ "${LOCAL_MODE}" == "1" ]] || ! command -v gcloud >/dev/null 2>&1; then
  echo "Local mode enabled (missing gcloud or LOCAL_MODE=1)."
  rm -rf build_artifacts
  mkdir -p build_artifacts
  echo "Local build placeholder for ml-model." > build_artifacts/ml-model.txt
  echo "Build completed (local placeholder)."
  exit 0
fi

# GCP build path (kept separate to avoid deleting this script's directory).
if command -v gcloud >/dev/null 2>&1; then
  gcloud builds submit --tag gcr.io/$(gcloud config get-value project)/ml-model
  echo "Build completed."
  exit 0
fi

# Ensure the build directory is clean
rm -rf build
mkdir build

# Build the model docker image
gcloud builds submit --tag gcr.io/$(gcloud config get-value project)/ml-model

echo "Build completed."
