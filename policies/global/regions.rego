package global.regions

allowed_regions := {"ap-south-1", "us-east-1"}

deny[msg] {
  r := input.resource_changes[_]

  r.type == "aws_s3_bucket"

  not r.change.after.region in allowed_regions

  msg := sprintf(
    "Region '%s' is not allowed",
    [r.change.after.region]
  )
}