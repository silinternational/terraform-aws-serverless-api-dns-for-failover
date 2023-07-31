
locals {
  aws_region           = data.aws_region.primary.name
  aws_region_secondary = data.aws_region.secondary.name
}

data "aws_region" "primary" {}

data "aws_region" "secondary" {
  provider = aws.secondary
}

module "custom_domains" {
  source = "./modules/custom-domains"

  api_name              = var.api_name
  api_stage             = var.serverless_stage
  certificate_subdomain = var.subdomain
  cloudflare_zone_name  = var.cloudflare_zone_name

  providers = {
    aws           = aws
    aws.secondary = aws.secondary
  }
}

module "fail_over_cnames" {
  source = "./modules/fail-over-cnames"

  aws_region                   = local.aws_region
  aws_region_secondary         = local.aws_region_secondary
  cloudflare_proxy_status      = var.cloudflare_proxy_status
  cloudflare_zone_name         = var.cloudflare_zone_name
  primary_api_gateway_domain   = module.custom_domains.primary_api_gateway_domain
  secondary_api_gateway_domain = module.custom_domains.secondary_api_gateway_domain
  subdomain                    = var.subdomain
}
