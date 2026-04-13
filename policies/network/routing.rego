package network.routing

deny contains msg if {
  not route_table_exists
  msg := "At least one route table must be defined"
}

route_table_exists if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_route_table"
}