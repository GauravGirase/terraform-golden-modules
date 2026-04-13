package s3.security

deny[msg] if {
	resource := input.resource_changes[_]
	resource.type == "aws_s3_bucket"

	after := resource.change.after
	after.acl == "public-read" # or public-read-write

	msg := sprintf("S3 bucket %s is public", [resource.address])
}
