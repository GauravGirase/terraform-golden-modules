package s3.tags

import data.lib.tags

########################################
# Missing required tags
########################################

deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  tags_obj := object.get(r.change.after, "tags", {})

  missing := tags.missing_tags(tags_obj)

  count(missing) > 0

  msg := sprintf(
    "S3 bucket '%s' missing tags: %v",
    [r.change.after.bucket, missing]
  )
}

########################################
# Invalid env tag
########################################

deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  tags_obj := object.get(r.change.after, "tags", {})

  tags.invalid_env(tags_obj)

  msg := sprintf(
    "Invalid env tag for bucket '%s'",
    [r.change.after.bucket]
  )
}

########################################
# Owner tag must not be empty
########################################

deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  tags_obj := object.get(r.change.after, "tags", {})

  tags.empty_tag(tags_obj, "owner")

  msg := sprintf(
    "Owner tag cannot be empty for '%s'",
    [r.change.after.bucket]
  )
}