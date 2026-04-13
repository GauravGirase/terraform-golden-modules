package lib.tags

########################################
# Required tags across org
########################################

required_tags := {"env", "owner", "cost_center"}

########################################
# Returns missing tags
########################################

missing_tags(tags) = missing if {
  missing := required_tags - object.keys(tags)
}

########################################
# Valid environments
########################################

valid_envs := {"dev", "staging", "prod"}

########################################
# Invalid env detection (safe)
########################################

invalid_env(tags) if {
  val := tags.env
  val != null
  not val in valid_envs
}

########################################
# Empty tag detection (safe access)
########################################

empty_tag(tags, key) if {
  key in object.keys(tags)
  tags[key] == ""
}