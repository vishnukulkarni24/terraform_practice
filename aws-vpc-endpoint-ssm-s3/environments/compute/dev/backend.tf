terraform {
  backend "s3" {
    bucket = "tf-b20-state-2026-06-24"
    key    = "infra/compute/dev/endpoints/terraform.tfstate"
    region = "ap-south-1"
  }
}