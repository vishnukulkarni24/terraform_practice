# Existing Hosted Zone

data "aws_route53_zone" "main" {

  name = var.domain_name

  private_zone = false
}

# ACM Validation Records

resource "aws_route53_record" "cert_validation" {

  for_each = {

    for dvo in aws_acm_certificate.cert.domain_validation_options :

    dvo.domain_name => {

      name   = dvo.resource_record_name

      record = dvo.resource_record_value

      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true

  zone_id = data.aws_route53_zone.main.zone_id

  name = each.value.name

  type = each.value.type

  ttl = 60

  records = [each.value.record]
}

# Root Domain Alias

resource "aws_route53_record" "root" {

  zone_id = data.aws_route53_zone.main.zone_id

  name = var.domain_name

  type = "A"

  alias {

    name = aws_cloudfront_distribution.cdn.domain_name

    zone_id = aws_cloudfront_distribution.cdn.hosted_zone_id

    evaluate_target_health = false
  }
}