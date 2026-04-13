locals {
  ########################################
  # Platform Default Tags (Non-negotiable)
  ########################################

  default_tags = {
    managed_by = "terraform"
    module     = "network"
  }

  ########################################
  # Required Business Tags (from user)
  ########################################

  required_tags = {
    env         = var.tags["env"]
    owner       = var.tags["owner"]
    cost_center = var.tags["cost_center"]
  }

  ########################################
  # Final Merged Tags
  ########################################

  tags = merge(
    local.default_tags,
    local.required_tags,
    var.tags
  )
}