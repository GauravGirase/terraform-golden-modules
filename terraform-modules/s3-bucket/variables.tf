variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "tags" {
  type        = map(string)
  description = "Mandatory tags"
}

variable "kms_key_id" {
  type    = string
  default = null
}

variable "logging_bucket" {
  type    = string
  default = null
}

variable "lifecycle_rules" {
  type = list(object({
    id               = string
    transition_days  = number
    storage_class    = string
    expiration_days  = number
  }))
  default = []
}