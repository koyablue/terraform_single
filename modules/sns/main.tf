variable "project_name" {}
variable "stage" {}

resource "aws_sns_topic" "ses_bounce" {
  name = "${var.project_name}-${var.stage}-ses-bounce"
}

resource "aws_sns_topic" "ses_complaint" {
  name = "${var.project_name}-${var.stage}-ses-complaint"
}

resource "aws_sns_topic" "ses_delivery" {
  name = "${var.project_name}-${var.stage}-ses-delivery"
}