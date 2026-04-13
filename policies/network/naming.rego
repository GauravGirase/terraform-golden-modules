package network.naming

deny contains msg if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_vpc"

  name := r.change.after.tags.Name

  not startswith(name, "org-")

  msg := "VPC name must follow org-<env>-vpc format"
}