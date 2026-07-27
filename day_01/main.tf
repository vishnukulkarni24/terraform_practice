resource "aws_security_group" "allow_tls" {
  name        = "aws_sg"
  description = "day1 tf sg"
  vpc_id      = "vpc-06d8ffa23ad27eb53"

  tags = {
    Name = "tf day_01 sg"
    env = "dev"
  }
}



