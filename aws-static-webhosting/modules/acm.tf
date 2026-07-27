# ACM Certificate
# MUST be in us-east-1 for CloudFront

resource "aws_acm_certificate" "cert" {

  provider = aws.us_east_1

  domain_name = var.domain_name

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.domain_name}"
  ]

  tags = {

    Name        = "${var.project_name}-acm"

    Environment = var.environment

    ManagedBy   = "Terraform"

    Project     = var.project_name
  }

  lifecycle {

    create_before_destroy = true
  }
}

# ACM Validation

resource "aws_acm_certificate_validation" "cert_validation" {

  provider = aws.us_east_1

  certificate_arn = aws_acm_certificate.cert.arn

  validation_record_fqdns = [

    for record in aws_route53_record.cert_validation :

    record.fqdn
  ]
}