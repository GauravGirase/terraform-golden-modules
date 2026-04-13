package lib.tags

# Required tags across org
required_tags := {"env", "owner", "cost_center"}

# Returns missing tags
missing_tags(tags) = missing {
  missing := required_tags - object.keys(tags)
}

# Validate tag values (optional strict mode)
valid_envs := {"dev", "staging", "prod"}

invalid_env(tags) {
  tags.env
  not tags.env in valid_envs
}

empty_tag(tags, key) {
  tags[key] == ""
}