resource "aws_s3_bucket" "s3_bucket" {
  bucket        = "${var.stage}-${var.bucket_name}"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl = "public-read"
}

resource "aws_s3_bucket_cors_configuration" "cors_rules" {
  bucket = aws_s3_bucket.s3_bucket.bucket
  cors_rule {
    allowed_methods = ["PUT", "POST", "DELETE", "GET"]
    allowed_origins = ["*"]
    expose_headers = ["ETag"]
  }
}

