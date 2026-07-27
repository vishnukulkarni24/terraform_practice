#################################################
# ACM MODULE
#################################################



module "acm" {

  source = "../../../modules/acm"

  environment = var.environment

  project_name = var.project_name

  domain_name = "*.cloudyn.in"

  root_domain_name = "cloudyn.in"
}



module "security_group" {

  source = "../../../modules/app-stack/security-group"

  #################################################
  # ENVIRONMENT
  #################################################

  environment = var.environment

  #################################################
  # PROJECT
  #################################################

  project_name = var.project_name

  #################################################
  # VPC
  #################################################

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
}


#################################################
# LAUNCH TEMPLATE MODULE
#################################################

module "launch_template" {

  source = "../../../modules/app-stack/launch-template"

  #################################################
  # ENVIRONMENT
  #################################################

  environment = var.environment

  #################################################
  # PROJECT
  #################################################

  project_name = var.project_name

  #################################################
  # EC2
  #################################################

  instance_type = var.instance_type

  key_name = var.key_name

  #################################################
  # SECURITY GROUP
  #################################################

  ec2_security_group_id = module.security_group.ec2_security_group_id
}


#################################################
# TARGET GROUP MODULE
#################################################

module "target_group" {

  source = "../../../modules/app-stack/target-group"

  #################################################
  # ENVIRONMENT
  #################################################

  environment = var.environment

  #################################################
  # PROJECT
  #################################################

  project_name = var.project_name

  #################################################
  # VPC
  #################################################

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
}


#################################################
# ALB MODULE
#################################################

module "alb" {

  source = "../../../modules/app-stack/alb"

  #################################################
  # ENVIRONMENT
  #################################################

  environment = var.environment

  #################################################
  # PROJECT
  #################################################

  project_name = var.project_name

  #################################################
  # NETWORK
  #################################################

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id

  public_subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids

  #################################################
  # SECURITY GROUP
  #################################################

  alb_security_group_id = module.security_group.alb_security_group_id

  #################################################
  # TARGET GROUP
  #################################################

  target_group_arn = module.target_group.target_group_arn

  #################################################
  # ACM CERTIFICATE
  #################################################

  acm_certificate_arn = module.acm.acm_certificate_arn
}

#################################################
# AUTO SCALING GROUP MODULE
#################################################

module "asg" {

  source = "../../../modules/app-stack/asg"

  #################################################
  # ENVIRONMENT
  #################################################

  environment = var.environment

  #################################################
  # PROJECT
  #################################################

  project_name = var.project_name

  #################################################
  # PRIVATE SUBNETS
  #################################################

 private_subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids
  #private_subnet_ids = data.terraform_remote_state.network.outputs.public_subnet_ids
  #################################################
  # LAUNCH TEMPLATE
  #################################################

  launch_template_id = module.launch_template.launch_template_id

  launch_template_latest_version = module.launch_template.launch_template_latest_version

  #################################################
  # TARGET GROUP
  #################################################

  target_group_arn = module.target_group.target_group_arn

  #################################################
  # ASG CAPACITY
  #################################################

  min_size = var.min_size

  max_size = var.max_size

  desired_capacity = var.desired_capacity
}


#################################################
# DNS MODULE
#################################################

module "dns" {

  source = "../../../modules/dns"

  root_domain_name = "cloudyn.in"

  record_name = "backend.cloudyn.in"

  alb_dns_name = module.alb.alb_dns_name

  alb_zone_id = module.alb.alb_zone_id
}