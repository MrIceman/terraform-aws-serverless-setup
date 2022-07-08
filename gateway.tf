############################################
# API GATEWAY - Sets up & configure api gw
############################################

resource "aws_apigatewayv2_stage" "dev" {
  api_id = aws_apigatewayv2_api.gw_api.id
  name   = "develop"

  auto_deploy     = true
  stage_variables = {
    "database"       = var.dev_database
    "s3_url"         = module.qr_code_s3_bucket_dev.s3_url
    "s3_qr_code_bucket" = "develop-vendor-qr"
    "aws_secret"     = "PUT HERE OR READ FROM ENV FLAGS"
    "aws_key_id"     = "PUT HERE OR READ FROM ENV FLAGS"
    "aws_region"     = "PUT HERE OR READ FROM ENV FLAGS"
  }

}

resource "aws_apigatewayv2_api" "gw_api" {
  name          = "api api gateway v2"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_authorizer" "firebase_authorizer" {
  name             = "firebase_authorizer"
  identity_sources = ["$request.header.Authorization"]
  jwt_configuration {
    issuer   = "https://securetoken.google.com/your_fb_project"
    audience = ["fb_project"]
  }
  authorizer_type = "JWT"
  api_id          = aws_apigatewayv2_api.gw_api.id
}
