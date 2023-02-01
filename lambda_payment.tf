resource "aws_lambda_function" "payments" {
  filename         = data.archive_file.payment.output_path
  function_name    = "${local.name}-payment"
  handler          = "payment_handler.handler"
  role             = aws_iam_role.role_for_lambda.arn
  layers = [ "${aws_lambda_layer_version.lambda_layer.arn}" ]
  description      = join(" ", ["function for", local.name])
  runtime          = "nodejs14.x"
  timeout          = 30
  source_code_hash = data.archive_file.payment.output_base64sha256
  tags             = merge(local.tags, { Name = "${local.name}-payment" })
  environment {
    variables = {
      CLIENT_ID       = "9073f0833eb56cf55e3692efadf61a7c"
      SECRET_ID = "oHrr4tbnB1PH0uz6VQNUvfZfMk5IeaO9IUO62M8vFEoMi65Pyg2oPaTtIFK13ILM"
    }
  }
}

resource "aws_cloudwatch_log_group" "payment" {
  name              = "/aws/lambda/${aws_lambda_function.payments.function_name}"
  retention_in_days = 0
  tags              = merge(local.tags, { Name = "loggroup-${local.name}" })
}

resource "null_resource" "moncash_layer" {
  triggers = {
    cluster_instance_id = data.archive_file.payment.output_base64sha256
  }

 provisioner "local-exec" {
    
    command = "/bin/bash scripts/packager.sh"
  }
}