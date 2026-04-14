package s3.naming

########################################
# S3 bucket naming convention
########################################

deny contains msg if {
  r := input.resource_changes[_]
  r.type == "aws_s3_bucket"

  bucket := r.change.after.bucket
  bucket != null

  not startswith(bucket, "org-")

  msg := sprintf(
    "Bucket '%s' must follow naming convention org-<app>-<env>",
    [bucket]
  )
}
