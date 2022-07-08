data "archive_file" "lambda_zip" {
  source_file = var.lambda_path
  type        = "zip"
  output_path = "../../${var.lambda_name}.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name    = var.lambda_name
  filename         = "../../${var.lambda_name}.zip"
  role             = var.lambda_iam_role_arn
  handler          = var.handler
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "go1.x"
  environment {
    variables = var.environment
  }
}

resource "aws_apigatewayv2_integration" "integration" {
  api_id             = var.main_api
  description        = "Lambda Serverless Upstream Service"
  # Upstream
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.lambda.invoke_arn
  connection_type    = "INTERNET"
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "route" {
  count              = length(var.endpoints)
  api_id             = var.main_api
  route_key          = var.endpoints[count.index]["endpoint"]
  target             = "integrations/${aws_apigatewayv2_integration.integration.id}"
  # Authorization
  authorization_type = var.endpoints[count.index]["is_authenticated"] ? "JWT" : null
  authorizer_id      = var.endpoints[count.index]["is_authenticated"] ?  var.authorizer_id : null
}


resource "aws_lambda_permission" "auth_lambda_permission" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = var.api_source_arn
}
