resource "aws_network_acl" "private" {

  vpc_id = aws_vpc.main.id

  subnet_ids = aws_subnet.private[*].id

  #################################################
  # HTTPS INBOUND RESPONSE
  #################################################

  ingress {

    rule_no = 100

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 443

    to_port = 443
  }

  #################################################
  # EPHEMERAL RETURN TRAFFIC
  #################################################

  ingress {

    rule_no = 110

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 1024

    to_port = 65535
  }

  #################################################
  # HTTPS OUTBOUND
  #################################################

  egress {

    rule_no = 100

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 443

    to_port = 443
  }

  #################################################
  # DNS UDP
  #################################################

  egress {

    rule_no = 110

    protocol = "udp"

    action = "allow"

    cidr_block = var.vpc_cidr

    from_port = 53

    to_port = 53
  }

  #################################################
  # DNS TCP
  #################################################

  egress {

    rule_no = 120

    protocol = "tcp"

    action = "allow"

    cidr_block = var.vpc_cidr

    from_port = 53

    to_port = 53
  }

  #################################################
  # EPHEMERAL RETURN
  #################################################

  egress {

    rule_no = 130

    protocol = "tcp"

    action = "allow"

    cidr_block = "0.0.0.0/0"

    from_port = 1024

    to_port = 65535
  }

  tags = {

    Name = "${var.environment}-private-nacl"

    Environment = var.environment
  }
}