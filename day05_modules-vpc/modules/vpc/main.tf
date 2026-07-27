locals {
    common_tags = {
        name = var.environment

        managedb_by = var.managed_by

        project = var.project_name

    }
}


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

resource "aws_subnet" "public" {

  count = length(var.public_subnet)

  vpc_id = aws_vpc.main.id

  cidr_block = var.public_subnet[count.index]

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


#PRIVATE SUBNETS
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.environment}-private-subnet-${count.index + 1}"

    Environment = var.environment
    Type        = "private"
    ManagedBy   = "Terraform"

    "kubernetes.io/role/internal-elb" = "1"
  }
}

#igw
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-igw"
    }
  )
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-public-rt"
    }
  )
}

# Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-private-rt"
    }
  )
}

# Public Route Table Association
resource "aws_route_table_association" "public_assoc" {
  count = length(var.public_subnet)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Private Route Table Association
resource "aws_route_table_association" "private_assoc" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  depends_on = [
    aws_internet_gateway.gw
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-nat-eip"
    }
  )
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [
    aws_internet_gateway.gw
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${var.environment}-nat-gateway"
    }
  )
}