#################################################
# ENDPOINT SECURITY GROUP
#################################################

resource "aws_security_group" "endpoint_sg" {

  name = "${var.environment}-endpoint-sg"

  description = "Security Group for VPC Interface Endpoints"

  vpc_id = aws_vpc.main.id

  ingress {

    from_port = 443

    to_port = 443

    protocol = "tcp"

    cidr_blocks = [
      var.vpc_cidr
    ]
  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {

    Name        = "${var.environment}-endpoint-sg"
    Environment = var.environment
  }
}

#################################################
# S3 GATEWAY ENDPOINT
#################################################

resource "aws_vpc_endpoint" "s3" {

  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.${var.aws_region}.s3"

  vpc_endpoint_type = "Gateway"

  route_table_ids = [
    aws_route_table.private.id
  ]

  tags = {

    Name        = "${var.environment}-s3-endpoint"
    Environment = var.environment
  }
}

#################################################
# SSM ENDPOINT
#################################################

resource "aws_vpc_endpoint" "ssm" {

  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.${var.aws_region}.ssm"

  vpc_endpoint_type = "Interface"

  subnet_ids = aws_subnet.private[*].id

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {

    Name        = "${var.environment}-ssm-endpoint"
    Environment = var.environment
  }
}

#################################################
# EC2 MESSAGES ENDPOINT
#################################################

resource "aws_vpc_endpoint" "ec2messages" {

  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.${var.aws_region}.ec2messages"

  vpc_endpoint_type = "Interface"

  subnet_ids = aws_subnet.private[*].id

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {

    Name        = "${var.environment}-ec2messages-endpoint"
    Environment = var.environment
  }
}

#################################################
# SSM MESSAGES ENDPOINT
#################################################

resource "aws_vpc_endpoint" "ssmmessages" {

  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.${var.aws_region}.ssmmessages"

  vpc_endpoint_type = "Interface"

  subnet_ids = aws_subnet.private[*].id

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {

    Name        = "${var.environment}-ssmmessages-endpoint"
    Environment = var.environment
  }
}

#################################################
# STS ENDPOINT
#################################################

resource "aws_vpc_endpoint" "sts" {

  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.${var.aws_region}.sts"

  vpc_endpoint_type = "Interface"

  subnet_ids = aws_subnet.private[*].id

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {

    Name        = "${var.environment}-sts-endpoint"
    Environment = var.environment
  }
}

#################################################
# EC2 API ENDPOINT
#################################################

resource "aws_vpc_endpoint" "ec2" {

  vpc_id = aws_vpc.main.id

  service_name = "com.amazonaws.${var.aws_region}.ec2"

  vpc_endpoint_type = "Interface"

  subnet_ids = aws_subnet.private[*].id

  security_group_ids = [
    aws_security_group.endpoint_sg.id
  ]

  private_dns_enabled = true

  tags = {

    Name        = "${var.environment}-ec2-endpoint"
    Environment = var.environment
  }
}