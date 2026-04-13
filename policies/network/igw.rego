package network.igw

# Internet Gateway must exist
deny[msg] {
  not igw_exists
  msg := "VPC must have an Internet Gateway"
}

igw_exists {
  some r
  r := input.resource_changes[_]
  r.type == "aws_internet_gateway"
}