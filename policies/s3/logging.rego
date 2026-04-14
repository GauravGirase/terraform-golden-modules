package s3.logging

########################################
# Check logging exists
########################################

has_logging(resource_changes) if {
  some i
  resource_changes[i].type == "aws_s3_bucket_logging"
}

########################################
# Access logging must exist
########################################

deny contains msg if {
  not has_logging(input.resource_changes)

  msg := "S3 bucket must have access logging enabled"
}
