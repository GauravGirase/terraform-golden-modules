package network.nat

# NAT Gateway must exist (for private subnet internet access)
deny contains msg if {
  not nat_exists
  msg := "NAT Gateway must be configured"
}

nat_exists if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_nat_gateway"
}

# Enforce Elastic IP usage
deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_nat_gateway"

  not r.change.after.allocation_id

  msg := "NAT Gateway must use Elastic IP"
}