package s3.lifecycle
########################################
# Check lifecycle exists
########################################

has_lifecycle(resource_changes) if {
  some i
  resource_changes[i].type == "aws_s3_bucket_lifecycle_configuration"
}

########################################
# Lifecycle must exist
########################################

deny contains msg if {
  not has_lifecycle(input.resource_changes)

  msg := "S3 bucket must define lifecycle rules"
}
