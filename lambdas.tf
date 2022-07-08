module "lambda" {
  for_each = var.lambdas
  source   = "lambda"

  handler             = each.value["handler"]
  lambda_name         = each.value["lambda_name"]
  lambda_path         = each.value["lambda_path"]
  endpoints           = each.value["endpoints"]
  authorizer_id       = aws_apigatewayv2_authorizer.firebase_authorizer.id
  main_api            = aws_apigatewayv2_api.gw_api.id
  api_source_arn      = "${aws_apigatewayv2_api.gw_api.execution_arn}/*/*"
  lambda_iam_role_arn = aws_iam_role.lambda_iam_role.arn

  environment = {
    "database"  = var.dev_database
    "s3_url"    = module.qr_code_s3_bucket_dev.s3_url
    "s3_bucket" = var.default_bucket_name
  }
}

