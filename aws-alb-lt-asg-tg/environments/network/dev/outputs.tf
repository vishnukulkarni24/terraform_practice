#################################################
# VPC
#################################################

output "vpc_id" {

  value = module.vpc.vpc_id
}

output "vpc_cidr" {

  value = module.vpc.vpc_cidr
}

#################################################
# SUBNETS
#################################################

output "public_subnet_ids" {

  value = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {

  value = module.vpc.private_subnet_ids
}

#################################################
# ROUTE TABLES
#################################################

output "public_route_table_id" {

  value = module.vpc.public_route_table_id
}

output "private_route_table_ids" {

  value = module.vpc.private_route_table_ids
}

#################################################
# NAT GATEWAYS
#################################################

output "nat_gateway_ids" {

  value = module.vpc.nat_gateway_ids
}

#################################################
# NACL
#################################################

output "public_nacl_id" {

  value = module.vpc.public_nacl_id
}

output "private_nacl_id" {

  value = module.vpc.private_nacl_id
}