package network.subnets

# Must have at least 2 AZs (HA requirement)
deny[msg] {
  subnets := [r | r := input.resource_changes[_]; r.type == "aws_subnet"]

  count(subnets) < 2

  msg := "At least 2 subnets across AZs required (HA)"
}

# Public subnets must auto-assign public IP
deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_subnet"

  r.change.after.tags.type == "public"
  not r.change.after.map_public_ip_on_launch

  msg := "Public subnets must auto-assign public IPs"
}

# Private subnets must NOT assign public IP
deny[msg] {
  r := input.resource_changes[_]
  r.type == "aws_subnet"

  r.change.after.tags.type == "private"
  r.change.after.map_public_ip_on_launch == true

  msg := "Private subnets must not assign public IPs"
}