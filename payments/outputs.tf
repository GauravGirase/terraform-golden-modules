# ########################################
# # Core Identifiers
# ########################################

# output "bucket_name" {
#   description = "Name of the S3 bucket"
#   value       = aws_s3_bucket.this.bucket
# }

# output "bucket_arn" {
#   description = "ARN of the S3 bucket"
#   value       = aws_s3_bucket.this.arn
# }

# ########################################
# # Access & Integration
# ########################################

# output "bucket_domain_name" {
#   description = "Bucket domain name"
#   value       = aws_s3_bucket.this.bucket_domain_name
# }

# output "bucket_regional_domain_name" {
#   description = "Regional domain name (used for integrations like CloudFront)"
#   value       = aws_s3_bucket.this.bucket_regional_domain_name
# }

# ########################################
# # Security & Encryption
# ########################################

# output "kms_key_id" {
#   description = "KMS key used for encryption (if applicable)"
#   value       = var.kms_key_id
# }

# ########################################
# # Logging & Lifecycle
# ########################################

# output "logging_bucket" {
#   description = "Target bucket for access logs"
#   value       = var.logging_bucket
# }

# ########################################
# # Platform-Friendly Contract Output
# ########################################

# output "storage_contract" {
#   description = "Standardized storage contract for platform consumption"

#   value = {
#     type        = "s3"
#     bucket      = aws_s3_bucket.this.bucket
#     arn         = aws_s3_bucket.this.arn
#     region      = data.aws_region.current.name
#     kms_enabled = var.kms_key_id != null
#   }
# }