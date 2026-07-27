terraform {
  backend "s3" {
    bucket = "tf-b20-state-2026-06-24"
    key    = "compute/security/IAM/depends_on/terraform.tfstate"
    region = "ap-south-1"
  }
}