module "aws_vpc" {
  source = "../../modules/vpc"

  environment        = var.environment
  managed_by         = var.managed_by
  project_name       = var.project_name
  vpc_cidr           = var.vpc_cidr
  aws_region         = var.aws_region
  public_subnet      = var.public_subnet
  private_subnets    = var.private_subnets
  availability_zones = var.availability_zones
}



module "ec2" {
  source = "../../modules/ec2"

  ami_id              = var.ami_id
  instance_type       = var.instance_type
  subnet_id           = module.vpc.public_subnet_id
  security_group_ids  = [module.vpc.security_group_id]
  key_name            = var.key_name
  associate_public_ip = true

  environment = var.environment

  common_tags = {
    Environment = var.environment
    ManagedBy   = var.managed_by
    Project     = var.project_name
  }
}
