resource "aws_security_group" "aws_tf_sg" {
  name        = "aws_sg"
  description = "day2 tf sg"
  vpc_id      = "vpc-027e2c73d39becbdf"

  tags = {
    Name = "tf_day_02"
    env = "dev1"
  }
}



