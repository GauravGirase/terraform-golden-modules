package s3.versioning

deny[msg] if {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket"

  after := resource.change.after

  not after.versioning.enabled

  msg := sprintf("S3 bucket %s has versioning disabled", [resource.address])
}
