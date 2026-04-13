package lib.aws

# Detect wildcard principal
is_wildcard_principal(policy) {
  contains(policy, "\"Principal\":\"*\"")
}

# Detect public access via Effect Allow + *
is_public_policy(policy) {
  contains(policy, "\"Effect\":\"Allow\"")
  contains(policy, "\"Principal\":\"*\"")
}

# Check if KMS is used
uses_kms(rule) {
  contains(tostring(rule), "aws:kms")
}

# Check if encryption exists
has_encryption(resource_changes) {
  some i
  resource_changes[i].type == "aws_s3_bucket_server_side_encryption_configuration"
}

# Check lifecycle exists
has_lifecycle(resource_changes) {
  some i
  resource_changes[i].type == "aws_s3_bucket_lifecycle_configuration"
}

# Check logging exists
has_logging(resource_changes) {
  some i
  resource_changes[i].type == "aws_s3_bucket_logging"
}