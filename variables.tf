
variable "app_name" {
  description = "Short name for the app (e.g. 'my-api'). Used as the subdomain."
  type        = string
}

variable "cloudflare_zone_name" {
  description = "Cloudflare zone (aka domain) name"
  type        = string
}

variable "serverless_stage" {
  description = "Short name for the stage (aka environment): 'dev' or 'prod'"
  type        = string
}
