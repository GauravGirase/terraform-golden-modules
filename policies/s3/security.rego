package s3.security

import data.lib.aws

########################################
# No public ACL
########################################

deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  r.change.after.acl == "public-read"

  msg := sprintf(
    "Bucket '%s' uses public ACL",
    [r.change.after.bucket]
  )
}

########################################
# Public access block must exist + be enforced
########################################

deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket_public_access_block"

  not r.change.after.block_public_acls
  not r.change.after.block_public_policy
  not r.change.after.ignore_public_acls
  not r.change.after.restrict_public_buckets

  msg := "All public access block settings must be enabled"
}

########################################
# No wildcard principals in bucket policy
########################################

deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket_policy"

  aws.is_wildcard_principal(tostring(r.change.after.policy))

  msg := "Wildcard principal detected in bucket policy"
}