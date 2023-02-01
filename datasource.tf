# data "aws_iam_account_alias" "current" {}



# Lamda function
data "archive_file" "payment" {
  type        = "zip"
  source_file = "${path.module}/functions/payment_handler.js"
  output_path = "${path.module}/functions/bundles/payment_handler.zip"
}

data "archive_file" "verification" {
  type        = "zip"
  source_file = "${path.module}/functions/verification_handler.js"
  output_path = "${path.module}/functions/bundles/verification_handler.zip"
}

