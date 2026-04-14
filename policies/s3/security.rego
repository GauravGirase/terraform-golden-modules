package s3.security

deny contains msg if {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket_public_access_block"
  r.change.after != null
  not r.change.after.block_public_acls
  msg := "block_public_acls must be true"
}

deny contains msg if {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket_public_access_block"
  r.change.after != null
  not r.change.after.block_public_policy
  msg := "block_public_policy must be true"
}

deny contains msg if {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket_public_access_block"
  r.change.after != null
  not r.change.after.ignore_public_acls
  msg := "ignore_public_acls must be true"
}

deny contains msg if {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket_public_access_block"
  r.change.after != null
  not r.change.after.restrict_public_buckets
  msg := "restrict_public_buckets must be true"
}
