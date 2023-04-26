#!/bin/bash

# Set the tag value to look for
USER_NAME="my-user"

# Get the VPC ID(s) based on the tag value
VPC_IDS=$(aws ec2 describe-vpcs --filters "Name=tag:USER_NAME,Values=$USER_NAME" --query "Vpcs[].VpcId" --output text)

# Delete the VPC(s) by ID
for VPC_ID in $VPC_IDS; do
  echo "Deleting VPC with ID $VPC_ID..."
  aws ec2 delete-vpc --vpc-id $VPC_ID
done