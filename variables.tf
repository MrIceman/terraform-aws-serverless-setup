variable "region" {
  description = "AWS region"
  default     = "us-central-1"
}

variable "dev_database" {
  description = "database url for dev"
  default     = "YOUR_PSQL_DNS" # ideally you create your own RDS resource and set the url here
}

variable "lambdas" {
  description = "lambdas to be registered"
  type        = map(object({
    handler     = string
    lambda_name = string
    lambda_path = string
    endpoints   = list(object({
      endpoint         = string
      is_authenticated = bool
    }))
  }))
}


variable "default_bucket_name" {
  description = "name of your bucket"
  type        = string
}

variable "stage_name" {
  description = "name of your stage / environment (e.g. prod, dev, test)"
  type        = string
}

variable "gateway_stage_invoke_url" {
  description = "the invoke url of your gateway"
  type = any
  default = aws_apigatewayv2_stage.dev.invoke_url
}