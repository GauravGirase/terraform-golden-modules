package s3.lifecycle

import data.lib.aws

deny[msg] {
  not aws.has_lifecycle(input.resource_changes)

  msg := "S3 bucket must define lifecycle rules"
}