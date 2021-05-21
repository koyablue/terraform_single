variable "ses_verify_email_address" {}
variable "domain_name" {}
variable "dev_domain_name" {}
variable "sns_topic_bounce_arn" {}
variable "sns_topic_complaint_arn" {}
variable "sns_topic_delivery_arn" {}

/**
email
*/
//verify email address
resource "aws_ses_email_identity" "verify_email" {
  email = var.ses_verify_email_address
}

resource "aws_ses_identity_notification_topic" "email_bounce_notification" {
  topic_arn                = var.sns_topic_bounce_arn
  notification_type        = "Bounce"
  identity                 = aws_ses_domain_identity.verify_email.email
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "email_complaint_notification" {
  topic_arn                = var.sns_topic_complaint_arn
  notification_type        = "Complaint"
  identity                 = aws_ses_domain_identity.verify_email.email
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "email_delivery_notification" {
  topic_arn                = var.sns_topic_delivery_arn
  notification_type        = "Delivery"
  identity                 = aws_ses_domain_identity.verify_email.email
  include_original_headers = true
}

/**
production domain
*/
//verify domain of production environmenr
resource "aws_ses_domain_identity" "verify_domain" {
  domain = var.domain_name
}

resource "aws_ses_identity_notification_topic" "pro_bounce_notification" {
  topic_arn                = var.sns_topic_bounce_arn
  notification_type        = "Bounce"
  identity                 = aws_ses_domain_identity.verify_domain.domain
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "pro_complaint_notification" {
  topic_arn                = var.sns_topic_bounce_arn
  notification_type        = "Complaint"
  identity                 = aws_ses_domain_identity.verify_domain.domain
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "pro_delivery_notification" {
  topic_arn                = var.sns_topic_bounce_arn
  notification_type        = "Delivery"
  identity                 = aws_ses_domain_identity.verify_domain.domain
  include_original_headers = true
}

/**
development domain
*/
//verify domain of development environment
resource "aws_ses_domain_identity" "verify_dev_domain" {
    domain = var.dev_domain_name
}

resource "aws_ses_identity_notification_topic" "dev_bounce_notification" {
  topic_arn                = var.sns_topic_bounce_arn
  notification_type        = "Bounce"
  identity                 = aws_ses_domain_identity.verify_dev_domain.domain
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "dev_complaint_notification" {
  topic_arn                = var.sns_topic_bounce_arn
  notification_type        = "Complaint"
  identity                 = aws_ses_domain_identity.verify_dev_domain.domain
  include_original_headers = true
}

resource "aws_ses_identity_notification_topic" "dev_delivery_notification" {
  topic_arn                = var.sns_topic_bounce_arn
  notification_type        = "Delivery"
  identity                 = aws_ses_domain_identity.verify_dev_domain.domain
  include_original_headers = true
}