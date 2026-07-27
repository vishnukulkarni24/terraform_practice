#!/bin/bash

#################################################
# ROOT PROJECT
#################################################

PROJECT_NAME="aws-vpc-endpoint-ssm-s3"

mkdir -p ${PROJECT_NAME}

cd ${PROJECT_NAME} || exit

#################################################
# ENVIRONMENTS
#################################################

mkdir -p environments/network/{dev,qa,uat,prod}

mkdir -p environments/compute/{dev,qa,uat,prod}

#################################################
# MODULES
#################################################

mkdir -p modules/vpc

mkdir -p modules/iam

mkdir -p modules/security-group

mkdir -p modules/ec2

mkdir -p modules/s3

mkdir -p modules/endpoint-policy

#################################################
# GLOBAL
#################################################

mkdir -p global/backend

#################################################
# SCRIPTS
#################################################

mkdir -p scripts

#################################################
# NETWORK ENV FILES
#################################################

for env in dev qa uat prod
do

touch environments/network/${env}/main.tf

touch environments/network/${env}/variables.tf

touch environments/network/${env}/outputs.tf

touch environments/network/${env}/providers.tf

touch environments/network/${env}/backend.tf

touch environments/network/${env}/terraform.tfvars

done

#################################################
# COMPUTE ENV FILES
#################################################

for env in dev qa uat prod
do

touch environments/compute/${env}/main.tf

touch environments/compute/${env}/data.tf

touch environments/compute/${env}/variables.tf

touch environments/compute/${env}/outputs.tf

touch environments/compute/${env}/providers.tf

touch environments/compute/${env}/backend.tf

touch environments/compute/${env}/terraform.tfvars

done

#################################################
# VPC MODULE
#################################################

touch modules/vpc/main.tf

touch modules/vpc/endpoints.tf

touch modules/vpc/nacl.tf

touch modules/vpc/variables.tf

touch modules/vpc/outputs.tf

touch modules/vpc/providers.tf

#################################################
# IAM MODULE
#################################################

touch modules/iam/role.tf

touch modules/iam/policy.tf

touch modules/iam/variables.tf

touch modules/iam/outputs.tf

#################################################
# SECURITY GROUP MODULE
#################################################

touch modules/security-group/security-group.tf

touch modules/security-group/variables.tf

touch modules/security-group/outputs.tf

#################################################
# EC2 MODULE
#################################################

touch modules/ec2/ec2.tf

touch modules/ec2/userdata.sh

touch modules/ec2/variables.tf

touch modules/ec2/outputs.tf

#################################################
# S3 MODULE
#################################################

touch modules/s3/bucket.tf

touch modules/s3/policy.tf

touch modules/s3/variables.tf

touch modules/s3/outputs.tf

#################################################
# ENDPOINT POLICY MODULE
#################################################

touch modules/endpoint-policy/s3-policy.tf

touch modules/endpoint-policy/variables.tf

touch modules/endpoint-policy/outputs.tf

#################################################
# GLOBAL BACKEND
#################################################

touch global/backend/s3-backend.tf

#################################################
# DEPLOYMENT SCRIPTS
#################################################

touch scripts/deploy.sh

chmod +x scripts/deploy.sh

touch scripts/destroy.sh

chmod +x scripts/destroy.sh

#################################################
# ROOT FILES
#################################################

touch README.md

touch .gitignore

#################################################
# SHOW PROJECT STRUCTURE
#################################################

echo ""
echo "Project Structure Created Successfully"
echo ""