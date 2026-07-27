terraform {
  backend "s3" {
    bucket = "tf-state-bucket-s3-backend"
    key    = "storage/dev/workspaces/day_03/terraform.tfstate"
    region = "ap-south-1"
  }
}