output "gateway_url" {
  description = "gateway url"
  value       = var.gateway_stage_invoke_url
}

output "s3_vendor_qr_bucket_url" {
  value = module.qr_code_s3_bucket_dev.s3_url
}