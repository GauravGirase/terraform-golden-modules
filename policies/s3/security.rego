package s3.security

import data.lib.aws

# No public ACL
deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  r.change.after.acl == "public-read"

  msg := sprintf("Bucket '%s' uses public ACL",
    [r.change.after.bucket])
}

# Public access block must exist
deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket_public_access_block"

  not r.change.after.block_public_acls

  msg := "block_public_acls must be true"
}

# No wildcard principals
deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket_policy"

  aws.is_wildcard_principal(tostring(r.change.after.policy))

  msg := "Wildcard principal detected in bucket policy"
}