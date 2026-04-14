package s3.tags

########################################
# Required tags across org
########################################

required_tags := {"env", "owner", "cost_center"}
########################################
# Returns missing tags
########################################

missing_tags(tags) = missing if {
  missing := required_tags - object.keys(tags)
}

########################################
# Valid environments
########################################

valid_envs := {"dev", "staging", "prod"}

########################################
# Invalid env detection (safe)
########################################

invalid_env(tags) if {
  tags.env
  not tags.env in valid_envs
}

########################################
# Empty tag detection (safe access)
########################################

empty_tag(tags, key) if {
  key in object.keys(tags)
  tags[key] == ""
}
########################################
# Missing required tags
########################################

deny contains msg if {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  tags_obj := r.change.after.tags
  tags_obj != null

  missing := missing_tags(tags_obj)

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
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  tags_obj := r.change.after.tags
  invalid_env(tags_obj)

  msg := sprintf(
    "Invalid env tag for bucket '%s'",
    [r.change.after.bucket]
  )
}

########################################
# Owner tag must not be empty
########################################

deny contains msg if {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  tags_obj := r.change.after.tags
  empty_tag(tags_obj, "owner")

  msg := sprintf(
    "Owner tag cannot be empty for '%s'",
    [r.change.after.bucket]
  )
}
