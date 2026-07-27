module "static_site" {

  source = "../../modules/"

  aws_region = var.aws_region

  environment = var.environment

  project_name = var.project_name

  bucket_name = var.bucket_name

  domain_name = var.domain_name
}