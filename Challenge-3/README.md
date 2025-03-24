# Terraform Challenge 3: Deploy EC2 Instance with Nginx

This challenge involves deploying an EC2 instance with Nginx installed, and ensuring it's accessible over HTTP.

## Infrastructure Overview

This Terraform configuration deploys:

- An EC2 instance running Amazon Linux 2
- A security group allowing SSH and HTTP access
- An SSH key pair for secure access
- An Elastic IP associated with the instance
- Nginx web server installed via user data script

## Prerequisites

- AWS CLI configured with appropriate permissions
- Terraform installed
- Basic understanding of AWS and Terraform

## Files Included

- `main.tf` - Contains the main Terraform configuration
- `variables.tf` - Variable definitions
- `install-nginx.sh` - Bash script to install and configure Nginx
- `outputs.tf` - Defines output values

## Getting Started

1. Clone this repository
   ```bash
   git clone https://github.com/kmachinen/terraform-challenges.git
   cd terraform-challenges/Challenge-3
   ```
2. Initialize Terraform:
   ```
   terraform init
   ```
3. Review the execution plan:
   ```
   terraform plan
   ```
4. Apply the configuration:
   ```
   terraform apply
   ```
   When prompted, type `yes` to proceed

## Accessing the Instance

After deployment completes, the public IP address will be displayed in the outputs:

```
aws_instances_public_ips = [
  "<ip-address>"
]
```

To SSH into the instance:

```
chmod 600 citadel_private_key.pem
ssh -i "citadel_private_key.pem" ec2-user@<ip-address>
```

## Verifying Nginx Installation

Once connected to the instance, verify Nginx is running:

```
sudo systemctl status nginx
```

You should see output indicating Nginx is `active (running)`.

From your local machine, you can access the Nginx welcome page by navigating to:

```
http://<ip-address>:80
```

## Resource Cleanup

When you're done, destroy all created resources:

```
terraform destroy
```

When prompted, type `yes` to confirm.

## Additional Information

- The private key is saved locally as `citadel_private_key.pem`
- The public key is saved locally as `citadel_public_key.pub`
- The elastic IP's DNS name is saved to `citadel_public_dns.txt`
- The instance uses a t2.micro instance type by default
