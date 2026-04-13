package lib.aws

########################################
# Detect wildcard principal
########################################

is_wildcard_principal(policy) if {
  contains(policy, "\"Principal\":\"*\"")
}

########################################
# Detect public policy (Allow + *)
########################################

is_public_policy(policy) if {
  contains(policy, "\"Effect\":\"Allow\"")
  contains(policy, "\"Principal\":\"*\"")
}

########################################
# Check if KMS is used
########################################

uses_kms(rule) if {
  contains(tostring(rule), "aws:kms")
}

########################################
# Check if encryption exists
########################################

has_encryption(resource_changes) if {
  some i
  resource_changes[i].type == "aws_s3_bucket_server_side_encryption_configuration"
}

########################################
# Check lifecycle exists
########################################

has_lifecycle(resource_changes) if {
  some i
  resource_changes[i].type == "aws_s3_bucket_lifecycle_configuration"
}

########################################
# Check logging exists
########################################

has_logging(resource_changes) if {
  some i
  resource_changes[i].type == "aws_s3_bucket_logging"
}