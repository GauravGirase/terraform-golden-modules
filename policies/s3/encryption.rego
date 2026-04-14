package s3.encryption

########################################
# Check if KMS is used
########################################
uses_kms(rule) if {
    rule[_].apply_server_side_encryption_by_default.sse_algorithm == "aws:kms"
}

########################################
# Check if encryption exists
########################################
has_encryption(resource_changes) if {
    resource_changes[_].type == "aws_s3_bucket_server_side_encryption_configuration"
}



########################################
# Encryption must exist
########################################

deny contains msg if {
  not has_encryption(input.resource_changes)

  msg := "S3 bucket must have encryption enabled"
}

########################################
# KMS required for prod
########################################

deny contains msg if {
  input.variables.env == "prod"

  r := input.resource_changes[_]
  r.type == "aws_s3_bucket_server_side_encryption_configuration"

  not uses_kms(r.change.after.rule)

  msg := "Production buckets must use KMS encryption"
}
