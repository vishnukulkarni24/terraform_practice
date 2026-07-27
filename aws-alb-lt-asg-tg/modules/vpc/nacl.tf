#################################################
# PUBLIC NETWORK ACL
#################################################

resource "aws_network_acl" "public" {

  vpc_id = aws_vpc.main.id

  subnet_ids = aws_subnet.public[*].id

  #################################################
  # INBOUND RULES
  #################################################

  #################################################
  # ALLOW HTTP
  #################################################

  ingress {

    rule_no = 100

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 80

    to_port = 80
  }

  #################################################
  # ALLOW HTTPS
  #################################################

  ingress {

    rule_no = 110

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 443

    to_port = 443
  }

  #################################################
  # ALLOW SSH
  #################################################

  ingress {

    rule_no = 120

    protocol = "tcp"

    action = "allow"

    cidr_block = var.admin_access_cidr

    from_port = 22

    to_port = 22
  }

  #################################################
  # ALLOW EPHEMERAL PORTS
  #################################################

  ingress {

    rule_no = 130

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 1024

    to_port = 65535
  }

  #################################################
  # OUTBOUND RULES
  #################################################

  #################################################
  # ALLOW HTTP
  #################################################

  egress {

    rule_no = 100

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 80

    to_port = 80
  }

  #################################################
  # ALLOW HTTPS
  #################################################

  egress {

    rule_no = 110

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 443

    to_port = 443
  }

  #################################################
  # ALLOW EPHEMERAL PORTS
  #################################################

  egress {

    rule_no = 120

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 1024

    to_port = 65535
  }

  #################################################
  # TAGS
  #################################################

  tags = {

    Name = "${var.environment}-public-nacl"

    Environment = var.environment

    ManagedBy = "Terraform"

    Project = var.project_name

    Type = "public-network-acl"
  }
}

#################################################
# PRIVATE NETWORK ACL
#################################################

resource "aws_network_acl" "private" {

  vpc_id = aws_vpc.main.id

  subnet_ids = aws_subnet.private[*].id

  #################################################
  # INBOUND RULES
  #################################################

  #################################################
  # ALLOW HTTP FROM VPC
  #################################################

  ingress {

    rule_no = 100

    protocol = "tcp"

    action = "allow"

    cidr_block = var.vpc_cidr

    from_port = 80

    to_port = 80
  }

  #################################################
  # ALLOW HTTPS FROM VPC
  #################################################

  ingress {

    rule_no = 110

    protocol = "tcp"

    action = "allow"

    cidr_block = var.vpc_cidr

    from_port = 443

    to_port = 443
  }

  #################################################
  # ALLOW EPHEMERAL PORTS
  #################################################

  ingress {

    rule_no = 120

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 1024

    to_port = 65535
  }

  #################################################
  # OUTBOUND RULES
  #################################################

  #################################################
  # ALLOW HTTP
  #################################################

  egress {

    rule_no = 100

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 80

    to_port = 80
  }

  #################################################
  # ALLOW HTTPS
  #################################################

  egress {

    rule_no = 110

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 443

    to_port = 443
  }

  #################################################
  # ALLOW EPHEMERAL PORTS
  #################################################

  egress {

    rule_no = 120

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 1024

    to_port = 65535
  }

  #################################################
  # TAGS
  #################################################

  tags = {

    Name = "${var.environment}-private-nacl"

    Environment = var.environment

    ManagedBy = "Terraform"

    Project = var.project_name

    Type = "private-network-acl"
  }
}