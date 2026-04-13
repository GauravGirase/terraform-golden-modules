region = "ap-south-1"
bucket_name = "org-payments-dev"

env         = "dev"
owner       = "payments-team"
cost_center = "cc-123"

logging_bucket = "org-central-logs"

lifecycle_rules = [
  {
    id               = "cleanup"
    transition_days  = 30
    storage_class    = "STANDARD_IA"
    expiration_days  = 90
  }
]