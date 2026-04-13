########################################
# Core Inputs
########################################

variable "bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string

  validation {
    condition     = can(regex("^org-[a-z0-9-]+$", var.bucket_name))
    error_message = "Bucket name must follow pattern: org-<app>-<env>"
  }
}

########################################
# Environment Metadata
########################################

variable "env" {
  description = "Environment (dev/staging/prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.env)
    error_message = "env must be one of: dev, staging, prod"
  }
}

variable "owner" {
  description = "Owning team/service"
  type        = string

  validation {
    condition     = length(var.owner) > 2
    error_message = "owner must be a valid team name"
  }
}

variable "cost_center" {
  description = "Cost center for billing"
  type        = string
}

########################################
# Optional Features
########################################

variable "kms_key_id" {
  description = "KMS key ARN for encryption (required for prod)"
  type        = string
  default     = null
}

variable "logging_bucket" {
  description = "Central logging bucket"
  type        = string
  default     = null
}

variable "lifecycle_rules" {
  description = "Lifecycle configuration"
  type = list(object({
    id               = string
    transition_days  = number
    storage_class    = string
    expiration_days  = number
  }))
  default = []
}

########################################
# Derived Tags (optional override)
########################################

variable "extra_tags" {
  description = "Additional custom tags"
  type        = map(string)
  default     = {}
}