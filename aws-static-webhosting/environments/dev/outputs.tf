output "bucket_name" {

  value = module.static_site.bucket_name
}

output "bucket_arn" {

  value = module.static_site.bucket_arn
}

output "cloudfront_domain_name" {

  value = module.static_site.cloudfront_domain_name
}

output "cloudfront_distribution_id" {

  value = module.static_site.cloudfront_distribution_id
}

output "website_url" {

  value = module.static_site.website_url
}