variable "lambda_name" {
  description = "name of the lambda"
  type        = string
}

variable "lambda_path" {
  description = "path of the lambda file"
  type        = string
}

variable "handler" {
  description = "handler name"
  type        = string
}

variable "environment" {
  description = "environments for the lambda"
  type        = map(string)
}

variable "endpoints" {
  description = "allowed endpoints of the endpoint"
  type        = list(object({
    endpoint         = string
    is_authenticated = bool
  }))
}

variable "authorizer_id" {
  description = "id of the authorizer"
}

variable "main_api" {
  description = "main api"
  type        = string
}

variable "api_source_arn" {
  description = "arn of api gateway"
}

variable "lambda_iam_role_arn" {
  description = "iam role for lambdas"
}