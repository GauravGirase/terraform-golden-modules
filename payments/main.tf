
module "payments_bucket" {
  source = "git::https://github.com/GauravGirase/terraform-golden-modules.git//terraform-modules/s3-bucket?ref=v1.0.0"

  bucket_name    = var.bucket_name
  kms_key_id     = var.kms_key_id
  logging_bucket = var.logging_bucket

  lifecycle_rules = var.lifecycle_rules

  tags = merge({
    env         = var.env
    owner       = var.owner
    cost_center = var.cost_center
  }, var.extra_tags)
}