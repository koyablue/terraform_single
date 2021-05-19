variable "host_zone_id" {}
variable "domain_name" {}
variable "ttl" {}
variable "records" {}

resource "aws_route53_record" "domain_pro" {
  zone_id = var.host_zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = var.ttl
  records = var.records
}

resource "aws_route53_record" "domain_dev" {
  zone_id = var.host_zone_id
  name    = "dev.${var.domain_name}"
  type    = "A"
  ttl     = var.ttl
  records = var.records
}