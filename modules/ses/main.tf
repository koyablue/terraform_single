variable "ses_verify_email_address" {}
variable "domain_name" {}
variable "dev_domain_name" {}

//verify email address
resource "aws_ses_email_identity" "verify_email" {
  email = var.ses_verify_email_address
}

//verify domain of production environmenr
resource "aws_ses_domain_identity" "verify_domain" {
  domain = var.domain_name
}

//verify domain of development environment
resource "aws_ses_domain_identity" "verify_dev_domain" {
    domain = var.dev_domain_name
}
