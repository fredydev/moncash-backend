
output "api_endpoint" {
  value = aws_apigatewayv2_api.api.api_endpoint
}
output "make_payment" {
  value = aws_apigatewayv2_route.make_payment.id
}


output "verification" {
  value = aws_apigatewayv2_route.verification.id
}