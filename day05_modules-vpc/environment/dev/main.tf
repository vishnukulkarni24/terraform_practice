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

module "security_group" {

  source = "../../modules/security_group"

  vpc_id = module.aws_vpc.vpc_id
  environment  = var.environment
}

module "ec2" {

  source = "../../modules/ec2"

  ami_id = var.ami_id

  instance_type = var.instance_type

  key_name = var.key_name

  subnet_id = module.aws_vpc.public_subnet_id

  security_group_id = module.security_group.security_group_id

  instance_name = var.instance_name

  aws_region = var.aws_region

  user_data = file("${path.module}/user_data.sh")
  


}