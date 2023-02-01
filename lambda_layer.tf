resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "functions/lambda-layer.zip"
  layer_name = "moncash-layer"
  source_code_hash = "${data.archive_file.payment.output_base64sha256}"
  compatible_runtimes = ["nodejs12.x","nodejs14.x"]
  depends_on = [
    null_resource.moncash_layer
  ]
}