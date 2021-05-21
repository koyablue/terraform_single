variable "project_name" {}
variable "stage" {}

resource "aws_sns_topc" "ses_bounce" {
    name = "${var.project_name}-${var.stage}-ses-bounce"
}

resource "aws_sns_topc" "ses_complaint" {
    name = "${var.project_name}-${var.stage}-ses-complaint"
}

resource "aws_sns_topc" "ses_delivery" {
    name = "${var.project_name}-${var.stage}-ses-delivery"
}