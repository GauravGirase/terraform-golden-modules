locals {
  default_tags = {
    managed_by = "terraform"
    module     = "s3-bucket"
  }

  final_tags = merge(local.default_tags, var.tags)
}