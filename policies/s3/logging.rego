package s3.logging

import data.lib.aws

########################################
# Access logging must exist
########################################

deny contains msg if {
  not aws.has_logging(input.resource_changes)

  msg := "S3 bucket must have access logging enabled"
}