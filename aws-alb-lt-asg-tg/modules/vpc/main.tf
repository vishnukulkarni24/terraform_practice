#################################################
# LOCAL TAGS
#################################################

locals {

  common_tags = {

    Environment = var.environment

    ManagedBy = var.managed_by

    Project = var.project_name
  }
}

#################################################
# VPC
#################################################

resource "aws_vpc" "main" {

  cidr_block = var.vpc_cidr

  enable_dns_support = true

  enable_dns_hostnames = true

  tags = merge(

    local.common_tags,

    {
      Name = "${var.environment}-vpc"
    }
  )
}

#################################################
# INTERNET GATEWAY
#################################################

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = merge(

    local.common_tags,

    {
      Name = "${var.environment}-igw"
    }
  )
}

#################################################
# PUBLIC SUBNETS
#################################################

resource "aws_subnet" "public" {

  count = length(var.public_subnets)

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnets[count.index]

  availability_zone = var.availability_zones[count.index]

  map_public_ip_on_launch = true

  tags = merge(

    local.common_tags,

    {

      Name = "${var.environment}-public-subnet-${count.index + 1}"

      Type = "public"

      Tier = "web"

      "kubernetes.io/role/elb" = "1"
    }
  )
}

#################################################
# PRIVATE SUBNETS
#################################################

resource "aws_subnet" "private" {

  count = length(var.private_subnets)

  vpc_id = aws_vpc.main.id

  cidr_block = var.private_subnets[count.index]

  availability_zone = var.availability_zones[count.index]

  tags = merge(

    local.common_tags,

    {

      Name = "${var.environment}-private-subnet-${count.index + 1}"

      Type = "private"

      Tier = "application"

      "kubernetes.io/role/internal-elb" = "1"
    }
  )
}

#################################################
# ELASTIC IPS FOR NAT GATEWAYS
#################################################

resource "aws_eip" "nat_eip" {

  count = length(var.public_subnets)

  domain = "vpc"

  tags = merge(

    local.common_tags,

    {
      Name = "${var.environment}-nat-eip-${count.index + 1}"
    }
  )
}

#################################################
# NAT GATEWAYS
#################################################

resource "aws_nat_gateway" "nat" {

  count = length(var.public_subnets)

  allocation_id = aws_eip.nat_eip[count.index].id

  subnet_id = aws_subnet.public[count.index].id

  depends_on = [
    aws_internet_gateway.igw
  ]

  tags = merge(

    local.common_tags,

    {
      Name = "${var.environment}-nat-gateway-${count.index + 1}"
    }
  )
}

#################################################
# PUBLIC ROUTE TABLE
#################################################

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(

    local.common_tags,

    {
      Name = "${var.environment}-public-rt"
    }
  )
}

#################################################
# PRIVATE ROUTE TABLES
#################################################

resource "aws_route_table" "private" {

  count = length(var.private_subnets)

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = merge(

    local.common_tags,

    {
      Name = "${var.environment}-private-rt-${count.index + 1}"
    }
  )
}

#################################################
# PUBLIC ROUTE TABLE ASSOCIATIONS
#################################################

resource "aws_route_table_association" "public_assoc" {

  count = length(var.public_subnets)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id
}

#################################################
# PRIVATE ROUTE TABLE ASSOCIATIONS
#################################################

resource "aws_route_table_association" "private_assoc" {

  count = length(var.private_subnets)

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private[count.index].id
}