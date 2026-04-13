package s3.encryption

import data.lib.aws

########################################
# Encryption must exist
########################################

deny contains msg if {
  not aws.has_encryption(input.resource_changes)

  msg := "S3 bucket must have encryption enabled"
}

########################################
# KMS required for prod
########################################

deny contains msg if {
  input.variables.env == "prod"

  some r
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket_server_side_encryption_configuration"

  not aws.uses_kms(r.change.after.rule)

  msg := "Production buckets must use KMS encryption"
}