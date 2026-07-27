#################################################
# AMAZON SSM MANAGED POLICY
#################################################

resource "aws_iam_role_policy_attachment" "ssm" {

  role = aws_iam_role.ec2_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

#################################################
# S3 READ POLICY DOCUMENT
#################################################

data "aws_iam_policy_document" "s3_read_policy" {

  statement {

    sid = "ListBucket"

    effect = "Allow"

    actions = [

      "s3:ListBucket"
    ]

    resources = [

      var.bucket_arn
    ]
  }

  statement {

    sid = "ReadObjects"

    effect = "Allow"

    actions = [

      "s3:GetObject"
    ]

    resources = [

      "${var.bucket_arn}/*"
    ]
  }
}

#################################################
# CUSTOM POLICY
#################################################

resource "aws_iam_policy" "s3_read_only" {

  name = "${var.environment}-s3-read-policy"

  policy = data.aws_iam_policy_document.s3_read_policy.json
}

#################################################
# ATTACH POLICY
#################################################

resource "aws_iam_role_policy_attachment" "s3_read" {

  role = aws_iam_role.ec2_role.name

  policy_arn = aws_iam_policy.s3_read_only.arn
}