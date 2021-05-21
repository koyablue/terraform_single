output "sns_topic_bounce_arn" {
    value = aws_sns_topc.ses_bounce.arn
}

output "sns_topic_complaint_arn" {
    value = aws_sns_topc.ses_complaint.arn
}

output "sns_topic_delivery_arn" {
    value = aws_sns_topc.ses_delivery.arn
}