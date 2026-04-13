package s3.naming

deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  not startswith(r.change.after.bucket, "org-")

  msg := sprintf(
    "Bucket '%s' must follow naming convention org-<app>-<env>",
    [r.change.after.bucket]
  )
}