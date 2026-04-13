package s3.lifecycle

import data.lib.aws

########################################
# Lifecycle must exist
########################################

deny contains msg if {
  not aws.has_lifecycle(input.resource_changes)

  msg := "S3 bucket must define lifecycle rules"
}