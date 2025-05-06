#!/bin/bash

terraform init
terraform plan
terraform apply -auto-approve

# Assuming you are logged into AWS CLI with aws configure, get security group in default vpc.

# Get the default VPC ID
vpc_id=$(aws ec2 describe-vpcs \
  --filters "Name=isDefault,Values=true" \
  --query "Vpcs[0].VpcId" \
  --output text)

echo "Default VPC ID: $vpc_id"

# List security groups in the default VPC
aws ec2 describe-security-groups \
  --filters Name=vpc-id,Values=$vpc_id \
  --query "SecurityGroups[*].{Name:GroupName,ID:GroupId}" \
  --output table

