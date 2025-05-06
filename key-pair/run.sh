#!/bin/bash

terraform init
terraform plan
terraform apply -auto-approve

# Assuming you are logged into AWS CLI with aws configure, list EC2 key pairs
aws ec2 describe-key-pairs --query "KeyPairs[*].KeyName"
