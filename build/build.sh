#!/bin/bash

# Ensure the build directory is clean
rm -rf build
mkdir build

# Build the model docker image
gcloud builds submit --tag gcr.io/$(gcloud config get-value project)/ml-model

echo "Build completed."
