package s3.tags

import data.lib.tags

deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  missing := tags.missing_tags(r.change.after.tags)

  count(missing) > 0

  msg := sprintf("S3 bucket '%s' missing tags: %v",
    [r.change.after.bucket, missing])
}

deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  tags.invalid_env(r.change.after.tags)

  msg := sprintf("Invalid env tag for bucket '%s'",
    [r.change.after.bucket])
}

deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  tags.empty_tag(r.change.after.tags, "owner")

  msg := sprintf("Owner tag cannot be empty for '%s'",
    [r.change.after.bucket])
}