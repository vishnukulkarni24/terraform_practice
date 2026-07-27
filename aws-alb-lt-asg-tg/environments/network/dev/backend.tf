terraform {
  backend "s3" {
    bucket = "tf-b20-state-2026-06-24"
    key    = "aws/prod/alb/terraform.tfstate"
    region = "ap-south-1"

    encrypt = true

    use_lockfile = false
  }
}