package network.flowlogs

########################################
# Flow logs must be enabled for audit
########################################

deny contains msg if {
  not flow_logs_enabled

  msg := "VPC Flow Logs must be enabled"
}

########################################
# Detect flow logs resource existence
########################################

flow_logs_enabled if {
  some r
  r := input.resource_changes[_]
  r.type == "aws_flow_log"
}