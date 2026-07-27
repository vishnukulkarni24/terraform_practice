#################################################
# EC2 TRUST POLICY
#################################################

data "aws_iam_policy_document" "ec2_assume_role" {

  statement {

    effect = "Allow"

    actions = [

      "sts:AssumeRole"
    ]

    principals {

      type = "Service"

      identifiers = [

        "ec2.amazonaws.com"
      ]
    }
  }
}

#################################################
# IAM ROLE
#################################################

resource "aws_iam_role" "ec2_role" {

  name = "${var.environment}-ec2-ssm-role"

  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json

  tags = {

    Name = "${var.environment}-ec2-ssm-role"

    Environment = var.environment
  }
}

#################################################
# INSTANCE PROFILE
#################################################

resource "aws_iam_instance_profile" "ec2_profile" {

  name = "${var.environment}-ec2-instance-profile"

  role = aws_iam_role.ec2_role.name
}