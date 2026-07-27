#################################################
# NETWORK REMOTE STATE
#################################################

data "terraform_remote_state" "network" {

  backend = "s3"

  config = {

     bucket = "tf-b20-state-2026-06-24"
    key    = "env/compute/vpc/endpoints/terraform.tfstate"
    region = "ap-south-1"
  }
}