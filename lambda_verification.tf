resource "aws_lambda_function" "verification" {
  filename         = data.archive_file.verification.output_path
  function_name    = "${local.name}-verification"
  handler          = "verification_handler.handler"
  role             = aws_iam_role.role_for_lambda.arn
  layers = [ "${aws_lambda_layer_version.lambda_layer.arn}" ]
  description      = join(" ", ["function for", local.name])
  runtime          = "nodejs14.x"
  timeout          = 30
  source_code_hash = data.archive_file.verification.output_base64sha256
  tags             = merge(local.tags, { Name = "${local.name}-verification" })
  # environment {
  #   variables = {
  #     verification_TABLE       = "${aws_dynamodb_table.verification.name}"
  #     BUCKET_NAME = "${aws_s3_bucket.eccommerce_assets.bucket}"
  #   }
  # }
}

resource "aws_cloudwatch_log_group" "verification" {
  name              = "/aws/lambda/${aws_lambda_function.verification.function_name}"
  retention_in_days = 0
  tags              = merge(local.tags, { Name = "loggroup-${local.name}" })
}