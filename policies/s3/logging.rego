package s3.logging

import data.lib.aws

deny[msg] {
  not aws.has_logging(input.resource_changes)

  msg := "S3 bucket must have access logging enabled"
}