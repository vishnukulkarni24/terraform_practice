#################################################
# S3 BUCKET
#################################################

resource "aws_s3_bucket" "private_bucket" {

  bucket = var.bucket_name

  tags = {

    Name        = var.bucket_name

    Environment = var.environment

    ManagedBy   = "Terraform"

    Project     = "vpc-endpoint-demo"
  }
}

#################################################
# VERSIONING
#################################################

resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.private_bucket.id

  versioning_configuration {

    status = "Enabled"
  }
}

#################################################
# ENCRYPTION
#################################################

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {

  bucket = aws_s3_bucket.private_bucket.id

  rule {

    apply_server_side_encryption_by_default {

      sse_algorithm = "AES256"
    }
  }
}

#################################################
# BLOCK PUBLIC ACCESS
#################################################

resource "aws_s3_bucket_public_access_block" "private" {

  bucket = aws_s3_bucket.private_bucket.id

  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true
}
 