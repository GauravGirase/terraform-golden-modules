package s3.encryption

deny[msg] if {
  resource := input.resource_changes[_]
  resource.type == "aws_s3_bucket"

  after := resource.change.after

  not after.server_side_encryption_configuration.rule.apply_server_side_encryption_by_default.sse_algorithm

  msg := sprintf("S3 bucket %s missing encryption", [resource.address])
}
