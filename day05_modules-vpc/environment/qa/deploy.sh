#!/bin/bash

set -e

# Check if Terraform is installed
if ! command -v terraform &> /dev/null; then
    echo "Error: Terraform is not installed."
    exit 1
fi

###############################################
# APPLY
###############################################
apply() {

    echo "=================================="
    echo "Terraform Format"
    echo "=================================="
    terraform fmt -recursive

    echo "=================================="
    echo "Terraform Init"
    echo "=================================="
    terraform init

    echo "=================================="
    echo "Terraform Validate"
    echo "=================================="
    terraform validate

    echo "=================================="
    echo "Terraform Plan"
    echo "=================================="
    terraform plan -out=tfplan

    echo "=================================="
    echo "Terraform Apply"
    echo "=================================="
    terraform apply -auto-approve tfplan
}

###############################################
# DESTROY
###############################################
destroy() {

    echo "=================================="
    echo "Terraform Destroy"
    echo "=================================="
    terraform destroy -auto-approve
}

###############################################
# MAIN
###############################################
case "$1" in
    apply)
        apply
        ;;
    destroy)
        destroy
        ;;
    *)
        echo "Usage: $0 {apply|destroy}"
        exit 1
        ;;
esac