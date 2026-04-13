package global.regions

allowed_regions := {"ap-south-1", "us-east-1"}

deny[msg] if {
    r := input.resource_changes[_]
    r.type == "aws_s3_bucket"

    after := r.change.after
    after != null

    region := object.get(after, "region", null)
    region != null

    not region in allowed_regions

    msg := sprintf("Region '%s' is not allowed", [region])
}