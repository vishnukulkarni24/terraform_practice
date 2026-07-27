terraform {
  backend "s3" {
    bucket = "tf-b20-state-2026-06-24"
    key    = "security_identity_compilance/IAM/user/terraform.tfstate"
    region = "ap-south-1"
  }
}