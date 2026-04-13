package network.routing

deny[msg] {
  not route_table_exists
  msg := "At least one route table must be defined"
}

route_table_exists {
  some r
  r := input.resource_changes[_]
  r.type == "aws_route_table"
}