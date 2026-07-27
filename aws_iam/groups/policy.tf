resource "aws_iam_policy" "policy" {
  name        = "custom_policy_admin"
  path        = "/"
  description = "My test policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode(
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "*",
            "Resource": "*"
        }
    ]
}
  )

}


resource "aws_iam_policy" "ec2_policy_full_access_tf" {
  name        = "ec2_policy_full_access_tf"
  path        = "/"
  description = "ec2_policy_full_access_tf"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode(
  {
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "ec2:*",
			"Resource": "*"
		}
	]
}


  )

}

resource "aws_iam_group_policy_attachment" "ec2_full_access" {
  group      = aws_iam_group.developers.name
  policy_arn = aws_iam_policy.ec2_policy_full_access_tf.arn
}

