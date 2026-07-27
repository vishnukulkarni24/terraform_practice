#################################################
# EXISTING HOSTED ZONE
#################################################

data "aws_route53_zone" "main" {

  name = var.root_domain_name

  private_zone = false
}

#################################################
# DNS RECORD
#################################################

resource "aws_route53_record" "record" {

  zone_id = data.aws_route53_zone.main.zone_id

  name = var.record_name

  type = "A"

  alias {

    name = var.alb_dns_name

    zone_id = var.alb_zone_id

    evaluate_target_health = true
  }
}