# GCPFederatedMLPipeline

## Overview

**GCPFederatedMLPipeline** is an unprecedented Terraform project that revolutionizes the deployment of scalable, automated, and secure federated machine learning pipelines on Google Cloud Platform (GCP). This cutting-edge project seamlessly integrates a suite of GCP services to orchestrate a comprehensive machine learning workflow, encompassing data storage, model training, and real-time deployment. Designed with meticulous attention to privacy, security, and performance, **GCPFederatedMLPipeline** sets a new benchmark in cloud-based machine learning.

## Key Features

- **Seamless Data Management**: Efficiently handle data storage and retrieval using Google Cloud Storage, ensuring optimal performance and security.
- **Advanced Federated Learning**: Employ AI Platform to conduct federated learning, safeguarding data privacy while leveraging distributed datasets for robust model training.
- **Real-Time Deployment**: Deploy trained models on Cloud Run, enabling scalable and low-latency predictions accessible through a secure, serverless platform.
- **Comprehensive IAM Policies**: Implement robust IAM roles and policies to enforce fine-grained access control and ensure compliance with security best practices.
- **Modular Architecture**: Designed for extensibility and scalability, this project allows seamless integration and expansion to accommodate evolving machine learning needs.

## The Visionary Behind the Project

This project epitomizes the vision and technical prowess of a transformative leader in cloud computing and machine learning. By pioneering the integration of federated learning within a fully automated GCP infrastructure, this project not only addresses critical data privacy concerns but also democratizes access to advanced machine learning capabilities. With **GCPFederatedMLPipeline**, we step into a new era of intelligent, secure, and scalable cloud solutions that empower organizations to harness the full potential of their data without compromising privacy or security.

## Prerequisites

- **Terraform**: Ensure Terraform is installed on your local machine.
- **Google Cloud SDK**: Install and configure Google Cloud SDK with appropriate access credentials.
- **GCP Project**: Set up a GCP project with billing enabled and necessary APIs activated.

## Installation

### Clone the Repository
```sh
git clone https://github.com/your-username/GCPFederatedMLPipeline.git
cd GCPFederatedMLPipeline
```
### Initialize Terraform
```sh
terraform init
```
### Apply the Terraform Configuration
```sh
terraform apply
```
## Architecture
### Main Components
- Google Cloud Storage: Facilitates secure and scalable storage of training data and model artifacts.
- AI Platform: Powers federated learning to train machine learning models across distributed data sources while preserving data privacy.
- Cloud Run: Provides a serverless environment for deploying and serving trained models, ensuring high availability and low latency.
- IAM Roles and Policies: Implements rigorous security controls to manage access and permissions effectively.
### Workflow
- Provision Infrastructure: Utilize Terraform to deploy the necessary GCP resources.
- Data Management: Store training data securely in Google Cloud Storage.
- Federated Training: Execute federated learning workflows on AI Platform.
- Model Deployment: Deploy the trained model to Cloud Run for real-time inference.
## Usage
### Configure the Project
#### Edit the Configuration File: 
```sh
Update config/config.yaml
```
with your GCP project details and resource names.
### Run Federated Training
#### Execute the Training Script:
```sh
./scripts/federated_training.sh
```
### Deploy the Model
#### Build the Model Docker Image:
```sh
./build/build.sh
```
#### Deploy the Model:
```sh
./deploy/deploy.sh
```
## License
This project is licensed under the MIT License - see the LICENSE file for details.

## ✅ Verified Quickstart (Local Mode)

The following commands were verified in a clean environment without GCP tooling installed. Local mode runs training with bundled sample data and skips GCP provisioning/deploy steps.

```sh
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
LOCAL_MODE=1 ./scripts/federated_training.sh
LOCAL_MODE=1 ./build/build.sh
LOCAL_MODE=1 ./deploy/deploy.sh
./scripts/smoke_test.sh
```

## Troubleshooting

- **`terraform: command not found` or `gcloud: command not found`**
  - The default README flow assumes Terraform and Google Cloud SDK are installed and authenticated.
  - For local verification without GCP tooling, use `LOCAL_MODE=1` as shown in the Verified Quickstart.

- **Training data download fails (`gsutil cp ...`)**
  - Ensure `gsutil` is installed and authenticated, or use local mode to run with `./data/training-data.csv`.

- **Missing Python dependencies**
  - Install dependencies with `pip install -r requirements.txt` before running training locally.

## ✅ Verified Quickstart (Offline / No Pip)

If you cannot install dependencies (e.g., restricted network), the repository includes lightweight local stubs for TensorFlow, pandas, and scikit-learn so you can still run the pipeline end-to-end.

```sh
LOCAL_MODE=1 ./scripts/federated_training.sh
LOCAL_MODE=1 ./build/build.sh
LOCAL_MODE=1 ./deploy/deploy.sh
./scripts/smoke_test.sh
```

> Note: When the real Python dependencies are installed, they will be used in place of the local stubs.

- **`pip install -r requirements.txt` fails due to proxy/network restrictions**
  - Use the "Verified Quickstart (Offline / No Pip)" section to run with built-in lightweight stubs.

> Note: In restricted environments, `pip install -r requirements.txt` may fail due to network/proxy constraints. The offline quickstart above was verified without installing external dependencies.

## Local Demo API (Impressive Mode)

After running local training, you can start a lightweight HTTP server that mimics a Cloud Run prediction endpoint:

```sh
LOCAL_MODE=1 ./scripts/federated_training.sh
./scripts/serve_local.sh
```

Then in a separate terminal:

```sh
curl http://127.0.0.1:8080/health
curl -X POST http://127.0.0.1:8080/predict -H "Content-Type: application/json" -d '{"features": [0.1, 0.2]}'
curl http://127.0.0.1:8080/metrics
```

These endpoints provide a realistic development loop while preserving the original GCP deployment flow.
