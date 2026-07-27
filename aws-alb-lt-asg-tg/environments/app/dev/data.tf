#################################################
# REMOTE STATE - NETWORK
#################################################

data "terraform_remote_state" "network" {

  backend = "s3"

  config = {
    bucket = "tf-b20-state-2026-06-24"
    key    = "aws/prod/alb/terraform.tfstate"
    region = "ap-south-1"
  }
}