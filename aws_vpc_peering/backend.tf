terraform {
  backend "s3" {
    bucket       = "tf-state-bucket-s3-backend"
    key          = "storage/vpc/vpc_peering/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = false

  }
}