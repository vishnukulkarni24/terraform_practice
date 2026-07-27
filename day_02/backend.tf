terraform {
  backend "s3" {
    bucket = "tf-state-bucket-s3-backend"
    key    = "compute/dev/day_01/terraform.tfstate"
    region = "ap-south-1"
  }
}