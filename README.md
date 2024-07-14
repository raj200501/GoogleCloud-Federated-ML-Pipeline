# GCPFederatedMLPipeline

**GCPFederatedMLPipeline** is a Terraform project designed to deploy a scalable and automated federated machine learning pipeline on Google Cloud Platform (GCP). This project provisions necessary resources such as Google Cloud Storage buckets for data storage, AI Platform for federated model training, and Cloud Run for model deployment, with built-in capabilities to ensure data privacy and security.

## Features

- **Google Cloud Storage**: Stores training data and model artifacts.
- **AI Platform**: Configured for federated ML model training.
- **Cloud Run**: Deploys trained ML models for serving predictions.
- **IAM Roles and Policies**: Ensures proper permissions and security for each component.
- **Federated Learning**: Supports federated learning to enhance data privacy and security.

## Prerequisites

- Terraform installed on your local machine.
- Google Cloud SDK installed and configured with appropriate access.
- A GCP project set up.

## Installation

1. **Clone the repository**:
    ```sh
    git clone https://github.com/your-username/GCPFederatedMLPipeline.git
    cd GCPFederatedMLPipeline
    ```

2. **Initialize Terraform**:
    ```sh
    terraform init
    ```

3. **Apply the Terraform configuration**:
    ```sh
    terraform apply
    ```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
