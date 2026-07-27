#################################################
# LOCAL TAGS
#################################################

locals {

  common_tags = {

    Environment = var.environment

    ManagedBy = "Terraform"

    Project = "ssm-vpc-endpoint-demo"
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

      Name = "${var.environment}-public-${count.index + 1}"
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

      Name = "${var.environment}-private-${count.index + 1}"
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
# PRIVATE ROUTE TABLE
#################################################

resource "aws_route_table" "private" {

  vpc_id = aws_vpc.main.id

  tags = merge(

    local.common_tags,

    {

      Name = "${var.environment}-private-rt"
    }
  )
}

#################################################
# PUBLIC ROUTE TABLE ASSOCIATIONS
#################################################

resource "aws_route_table_association" "public" {

  count = length(var.public_subnets)

  subnet_id = aws_subnet.public[count.index].id

  route_table_id = aws_route_table.public.id
}

#################################################
# PRIVATE ROUTE TABLE ASSOCIATIONS
#################################################

resource "aws_route_table_association" "private" {

  count = length(var.private_subnets)

  subnet_id = aws_subnet.private[count.index].id

  route_table_id = aws_route_table.private.id
}