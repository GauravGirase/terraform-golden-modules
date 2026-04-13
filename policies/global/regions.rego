package global.regions

allowed_regions := {"ap-south-1", "us-east-1"}

deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  region := r.change.after.region
  region != null

  not region in allowed_regions

  msg := sprintf(
    "Region '%s' is not allowed",
    [region]
  )
}