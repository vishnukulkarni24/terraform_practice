#################################################
# DEMO FILE
#################################################

resource "aws_s3_object" "test_file" {

  bucket = aws_s3_bucket.private_bucket.id

  key = "test.txt"

  content = <<EOF
Hello from Private EC2 via VPC Endpoint

This file was uploaded using Terraform.

Environment: ${var.environment}
EOF

  content_type = "text/plain"
}