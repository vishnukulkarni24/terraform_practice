#################################################
# VPC
#################################################

output "vpc_id" {

  value = aws_vpc.main.id
}

output "vpc_cidr" {

  value = aws_vpc.main.cidr_block
}

#################################################
# SUBNETS
#################################################

output "public_subnet_ids" {

  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {

  value = aws_subnet.private[*].id
}

#################################################
# ROUTE TABLES
#################################################

output "public_route_table_id" {

  value = aws_route_table.public.id
}

output "private_route_table_ids" {

  value = aws_route_table.private[*].id
}

#################################################
# NAT GATEWAYS
#################################################

output "nat_gateway_ids" {

  value = aws_nat_gateway.nat[*].id
}

#################################################
# INTERNET GATEWAY
#################################################

output "internet_gateway_id" {

  value = aws_internet_gateway.igw.id
}

#################################################
# NETWORK ACLS
#################################################

output "public_nacl_id" {

  value = aws_network_acl.public.id
}

output "private_nacl_id" {

  value = aws_network_acl.private.id
}