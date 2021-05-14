variable "host_zone_id" {}
variable "domain_name" {}
variable "ttl" {}
variable "records" {}

resource "aws_route53_record" "domain" {
  zone_id = var.host_zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = var.ttl
  records = var.records
}