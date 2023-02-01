## https://learn.hashicorp.com/tutorials/terraform/lambda-api-gateway
# API Gateway

resource "aws_apigatewayv2_api" "api" {
    name          = join("-", [local.name, "api_gateway"])  
    protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "api" {  
    api_id = aws_apigatewayv2_api.api.id # create this resource
    name        = "dev"  
    auto_deploy = true
    access_log_settings {    
        destination_arn = aws_cloudwatch_log_group.api_gw.arn
        format = jsonencode({      
            requestId               = "$context.requestId"      
            sourceIp                = "$context.identity.sourceIp"      
            requestTime             = "$context.requestTime"      
            protocol                = "$context.protocol"      
            httpMethod              = "$context.httpMethod"      
            resourcePath            = "$context.resourcePath"      
            routeKey                = "$context.routeKey"      
            status                  = "$context.status"      
            responseLength          = "$context.responseLength"      
            integrationErrorMessage = "$context.integrationErrorMessage"      
        })  
    }
}


resource "aws_apigatewayv2_integration" "payment" {  
    api_id = aws_apigatewayv2_api.api.id
    integration_uri    = aws_lambda_function.payments.arn  
    integration_type   = "AWS_PROXY"  
    integration_method = "POST"
}

resource "aws_apigatewayv2_integration" "verification" {  
    api_id = aws_apigatewayv2_api.api.id
    integration_uri    = aws_lambda_function.verification.invoke_arn  
    integration_type   = "AWS_PROXY"  
    integration_method = "POST"
}

# API Gateway - routes
resource "aws_apigatewayv2_route" "make_payment"{
    api_id = aws_apigatewayv2_api.api.id
    route_key = "POST /v1/payment/order"  
    target    = "integrations/${aws_apigatewayv2_integration.payment.id}"
}

resource "aws_apigatewayv2_route" "verification" {  
    api_id = aws_apigatewayv2_api.api.id
    route_key = "GET /v1/payment/verify"  
    target    = "integrations/${aws_apigatewayv2_integration.verification.id}"
}


resource "aws_cloudwatch_log_group" "api_gw" {  
    name = "/aws/api_gw/${aws_apigatewayv2_api.api.name}"
    retention_in_days = 30
}

# Api Gateway - Lambda Permission
resource "aws_lambda_permission" "apigw_payment_lambda" {
  statement_id  = "AllowExecutionFromAPIGatewayForTenants"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.payments.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}
resource "aws_lambda_permission" "apigw_verification_lambda" {
  statement_id  = "AllowExecutionFromAPIGatewayForUsers"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.verification.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.api.execution_arn}/*/*"
}

##
