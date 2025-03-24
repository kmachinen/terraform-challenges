# Terraform Challenge 1

This challenge demonstrates how to deploy a web application in Kubernetes using Terraform. The deployment consists of a namespace, deployment with 4 replicas, and a NodePort service to expose the application.

## Prerequisites

- Terraform (version 1.1.5)
- Kubernetes cluster (kind, minikube, EKS, etc.)
- kubectl configured to connect to your cluster
- Basic understanding of Kubernetes and Terraform

## Project Structure

```
terraform-challenge-1/
├── main.tf
└── README.md
```

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/kmachinen/terraform-challenges.git
cd terraform-challenges/Challenge-1
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Review the execution plan

```bash
terraform plan
```

### 4. Apply the configuration

```bash
terraform apply
```

Type "yes" when prompted to create the resources.

## Verification

After applying the Terraform configuration, verify the deployment with these commands:

### 1. Check the namespace

```bash
kubectl get namespace webapp
```

### 2. Check the deployment

```bash
kubectl get deployments -n webapp
kubectl describe deployment frontend -n webapp
```

### 3. Check the pods

```bash
kubectl get pods -n webapp
```

### 4. Check the service

```bash
kubectl get services -n webapp
```

## Testing the Service

You can test the web application using port forwarding:

```bash
kubectl port-forward service/webapp-service -n webapp 8080:8080
```

In another terminal window:

```bash
curl localhost:8080
```

## Cleaning Up

To destroy all the resources created by Terraform:

```bash
terraform destroy
```

Type "yes" when prompted to destroy the resources.