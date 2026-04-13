package network.flowlogs

# Flow logs must be enabled for audit
deny[msg] {
  not flow_logs_enabled
  msg := "VPC Flow Logs must be enabled"
}

flow_logs_enabled {
  some r
  r := input.resource_changes[_]
  r.type == "aws_flow_log"
}