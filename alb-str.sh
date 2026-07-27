#!/bin/bash

#################################################
# ROOT PROJECT
#################################################

PROJECT_NAME="aws-alb-lt-asg-tg"

mkdir -p $PROJECT_NAME

cd $PROJECT_NAME || exit

#################################################
# ENVIRONMENTS
#################################################

mkdir -p environments/network/{dev,qa,uat,prod}

mkdir -p environments/app/{dev,qa,uat,prod}

#################################################
# MODULES
#################################################

mkdir -p modules/vpc

mkdir -p modules/acm

mkdir -p modules/dns

mkdir -p modules/app-stack/alb

mkdir -p modules/app-stack/asg

mkdir -p modules/app-stack/launch-template

mkdir -p modules/app-stack/security-group

mkdir -p modules/app-stack/target-group

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

touch environments/network/$env/main.tf

touch environments/network/$env/variables.tf

touch environments/network/$env/outputs.tf

touch environments/network/$env/backend.tf

touch environments/network/$env/providers.tf

touch environments/network/$env/terraform.tfvars

done

#################################################
# APP ENV FILES
#################################################

for env in dev qa uat prod
do

touch environments/app/$env/main.tf

touch environments/app/$env/data.tf

touch environments/app/$env/variables.tf

touch environments/app/$env/outputs.tf

touch environments/app/$env/backend.tf

touch environments/app/$env/providers.tf

touch environments/app/$env/terraform.tfvars

done

#################################################
# VPC MODULE FILES
#################################################

touch modules/vpc/main.tf

touch modules/vpc/nacl.tf

touch modules/vpc/variables.tf

touch modules/vpc/outputs.tf

touch modules/vpc/providers.tf

#################################################
# ACM MODULE FILES
#################################################

touch modules/acm/acm.tf

touch modules/acm/variables.tf

touch modules/acm/outputs.tf

touch modules/acm/providers.tf

#################################################
# DNS MODULE FILES
#################################################

touch modules/dns/main.tf

touch modules/dns/variables.tf

touch modules/dns/outputs.tf

#################################################
# ALB MODULE FILES
#################################################

touch modules/app-stack/alb/alb.tf

touch modules/app-stack/alb/variables.tf

touch modules/app-stack/alb/outputs.tf

touch modules/app-stack/alb/providers.tf

#################################################
# ASG MODULE FILES
#################################################

touch modules/app-stack/asg/asg.tf

touch modules/app-stack/asg/variables.tf

touch modules/app-stack/asg/outputs.tf

touch modules/app-stack/asg/providers.tf

#################################################
# LAUNCH TEMPLATE MODULE FILES
#################################################

touch modules/app-stack/launch-template/launch-template.tf

touch modules/app-stack/launch-template/variables.tf

touch modules/app-stack/launch-template/outputs.tf

touch modules/app-stack/launch-template/providers.tf

#################################################
# SECURITY GROUP MODULE FILES
#################################################

touch modules/app-stack/security-group/security-group.tf

touch modules/app-stack/security-group/variables.tf

touch modules/app-stack/security-group/outputs.tf

touch modules/app-stack/security-group/providers.tf

#################################################
# TARGET GROUP MODULE FILES
#################################################

touch modules/app-stack/target-group/target-group.tf

touch modules/app-stack/target-group/variables.tf

touch modules/app-stack/target-group/outputs.tf

touch modules/app-stack/target-group/providers.tf

#################################################
# GLOBAL BACKEND FILE
#################################################

touch global/backend/s3-backend.tf

#################################################
# ROOT FILES
#################################################

touch README.md

touch .gitignore

#################################################
# FINAL STRUCTURE
#################################################

echo ""

echo "#################################################"

echo "PROJECT STRUCTURE CREATED SUCCESSFULLY"

echo "#################################################"

echo ""