package network.naming

deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_vpc"

  not startswith(r.change.after.tags.Name, "org-")

  msg := "VPC name must follow org-<env>-vpc format"
}