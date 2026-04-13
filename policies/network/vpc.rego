package network.vpc

# Enforce private CIDR ranges only
deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_vpc"

  not startswith(r.change.after.cidr_block, "10.")

  msg := sprintf("VPC '%s' must use private CIDR (10.x.x.x)", [r.change.after.cidr_block])
}

# DNS must be enabled
deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_vpc"

  not r.change.after.enable_dns_support

  msg := "DNS support must be enabled for VPC"
}

# DNS hostnames must be enabled
deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_vpc"

  not r.change.after.enable_dns_hostnames

  msg := "DNS hostnames must be enabled"
}