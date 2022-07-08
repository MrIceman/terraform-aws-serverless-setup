module "qr_code_s3_bucket_dev" {
  source = "s3"

  bucket_name = var.default_bucket_name
  stage       = var.stage_name
}

