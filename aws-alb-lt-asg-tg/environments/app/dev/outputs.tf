
#################################################
# SECURITY GROUPS
#################################################

output "alb_security_group_id" {

  value = module.security_group.alb_security_group_id
}

output "ec2_security_group_id" {

  value = module.security_group.ec2_security_group_id
}
