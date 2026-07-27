terraform {
  backend "s3" {
    bucket = "tf-b20-state-2026-06-24"
    key    = "compute/day_04/file-provisioners/terraform.tfstate"
    region = "ap-south-1"
  }
}