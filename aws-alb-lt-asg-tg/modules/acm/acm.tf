#################################################
# ACM CERTIFICATE
#################################################

resource "aws_acm_certificate" "wildcard" {

  domain_name = var.domain_name

  validation_method = "DNS"

  subject_alternative_names = [

    var.root_domain_name
  ]

  lifecycle {

    create_before_destroy = true
  }

  tags = {

    Name = "${var.environment}-wildcard-acm"

    Environment = var.environment

    ManagedBy = "Terraform"

    Project = var.project_name
  }
}

#################################################
# ROUTE53 ZONE
#################################################

data "aws_route53_zone" "main" {

  name = var.root_domain_name

  private_zone = false
}

#################################################
# DNS VALIDATION RECORDS
#################################################

resource "aws_route53_record" "validation" {

  for_each = {

    for dvo in aws_acm_certificate.wildcard.domain_validation_options :

    dvo.domain_name => {

      name = dvo.resource_record_name

      record = dvo.resource_record_value

      type = dvo.resource_record_type
    }
  }

  allow_overwrite = true

  zone_id = data.aws_route53_zone.main.zone_id

  name = each.value.name

  type = each.value.type

  ttl = 60

  records = [
    each.value.record
  ]
}

#################################################
# ACM VALIDATION
#################################################

resource "aws_acm_certificate_validation" "wildcard" {

  certificate_arn = aws_acm_certificate.wildcard.arn

  validation_record_fqdns = [

    for record in aws_route53_record.validation :

    record.fqdn
  ]
}