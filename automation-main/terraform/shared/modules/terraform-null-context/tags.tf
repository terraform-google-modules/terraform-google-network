/*
  Description: Logic related to tags
  Comments:
    - N/A
*/

locals {
  tag_regex = local.defaults.regex_replace_chars_extended

  resource_tags = concat(
    var.resource_tags == null ? [] : var.resource_tags,
    var.context.resource_tags == null ? [] : var.context.resource_tags,
    local.defaults.resource_tags
  )

  tag_lookups = merge(local.lookup_map, {
    provision_date = local.provision_date
    resource_name  = local.resource_name
  })

  # MODULE TAGS
  module_tags = local.reset_module_values == true ? (
    coalesce(
      try(var.module_values.tags, null),
      local.defaults.basic_tags
    )) : (
    coalesce(
      try(var.context.module_values.tags, null),
      try(var.module_values.tags, null),
      local.defaults.basic_tags
  ))

  # ENVIRONMENT TAGS
  environment_tags = local.reset_environment_values == true ? (
    coalesce(
      try(var.environment_values.tags, null),
      local.defaults.basic_tags
    )) : (
    coalesce(
      try(var.context.environment_values.tags, null),
      try(var.environment_values.tags, null),
      local.defaults.basic_tags
  ))

  # CUSTOM TAGS
  custom_tags = local.reset_custom_values == true ? (
    coalesce(
      try(var.custom_values.tags, null),
      local.defaults.basic_tags
    )) : (
    coalesce(
      try(var.context.custom_values.tags, null),
      try(var.custom_values.tags, null),
      local.defaults.basic_tags
  ))

  # Generate additional tag definitions for every tag (tag + `_friendly_name`)
  friendly_name_tags = [
    for tag in concat(
      local.resource_tags,
      local.module_tags,
      local.environment_tags,
      local.custom_tags
      ) : {
      name         = "${tag.name}FriendlyName"
      value        = "${tag.value}_friendly_name"
      base_name    = tag.name
      base_value   = tag.value
      required     = false
      pass_context = false
    }
  ]

  # Additional tags to add to the base tags.
  additional_tags = (
    # If var.additional_tags is null, then look to see if var.context.additional_tags is null, if null then set additional_tags to null.
    # If var.context.additional_tags is not null, then use that value.
    var.additional_tags == null ? (var.context.additional_tags == null ? null : var.context.additional_tags) : (
      # If var.additional_tags is not null, then merge var.additional_tags with var.context.additional_tags if not null.
      var.context.additional_tags == null ? var.additional_tags : merge(var.context.additional_tags, var.additional_tags)
    )
  )

  # TAGGING LOGIC
  __resource_tags = tolist(
    concat(
      local.additional_tags == null ? [] : [for key, value in local.additional_tags : { (key) : trimspace(replace(value, local.tag_regex, local.defaults.replacement)) }],
      [for tag in local.resource_tags : (lookup(local.tag_lookups, tag.value, null) == null ? {} : { (tag.name) : trimspace(replace(local.tag_lookups[tag.value], local.tag_regex, local.defaults.replacement)) })],
      [for tag in local.module_tags : (lookup(local.tag_lookups, tag.value, null) == null ? {} : { (tag.name) : trimspace(replace(local.tag_lookups[tag.value], local.tag_regex, local.defaults.replacement)) })],
      [for tag in local.environment_tags : (lookup(local.tag_lookups, tag.value, null) == null ? {} : { (tag.name) : trimspace(replace(local.tag_lookups[tag.value], local.tag_regex, local.defaults.replacement)) })],
      [for tag in local.custom_tags : (lookup(local.tag_lookups, tag.value, null) == null ? {} : { (tag.name) : trimspace(replace(local.tag_lookups[tag.value], local.tag_regex, local.defaults.replacement)) })],
      [for tag in local.friendly_name_tags : (lookup(local.tag_lookups, tag.value, null) == null ? {} : { (tag.name) : trimspace(replace(local.tag_lookups[tag.value], local.tag_regex, local.defaults.replacement)) })],
    )
  )
  _resource_tags = zipmap(
    flatten(
      [for item in local.__resource_tags : keys(item)]
    ),
    flatten(
      [for item in local.__resource_tags : values(item)]
    )
  )

  # REQUIRED TAGS CHECK
  required_tags_check = local.skip_checks == true ? "CHECK SKIPPED" : join("", concat(
    [for tag in local.resource_tags : (tag.required ? try(local._resource_tags[tag.name], { local.defaults.errors.MISSING_REQUIRED_TAG : tag.name }) : "")],
    [for tag in local.module_tags : (tag.required ? try(local._resource_tags[tag.name], { local.defaults.errors.MISSING_REQUIRED_TAG : tag.name }) : "")],
    [for tag in local.environment_tags : (tag.required ? try(local._resource_tags[tag.name], { local.defaults.errors.MISSING_REQUIRED_TAG : tag.name }) : "")],
    [for tag in local.custom_tags : (tag.required ? try(local._resource_tags[tag.name], { local.defaults.errors.MISSING_REQUIRED_TAG : tag.name }) : "")]
  ))


  tags = merge(local._resource_tags, lookup(local.tag_lookups, local.labels.product_name, null) == null ? {} : { (local.labels.account_tag) : local.account_id })

  # separate out list of tags excluding those we know are always "known after apply"
  _tags_known = tolist(
    concat(
      local.additional_tags == null ? [] : [for key, value in local.additional_tags : { (key) : trimspace(replace(value, local.tag_regex, local.defaults.replacement)) }],
      [
        for tag in local.resource_tags : (lookup(local.tag_lookups, tag.value, null) == null ? {} : { (tag.name) : trimspace(replace(local.tag_lookups[tag.value], local.tag_regex, local.defaults.replacement)) })
        if tag.name != "ProvisionDate" && tag.name != "BuildUser"
      ],
      [for tag in local.module_tags : (lookup(local.tag_lookups, tag.value, null) == null ? {} : { (tag.name) : trimspace(replace(local.tag_lookups[tag.value], local.tag_regex, local.defaults.replacement)) })],
      [for tag in local.environment_tags : (lookup(local.tag_lookups, tag.value, null) == null ? {} : { (tag.name) : trimspace(replace(local.tag_lookups[tag.value], local.tag_regex, local.defaults.replacement)) })],
      [for tag in local.custom_tags : (lookup(local.tag_lookups, tag.value, null) == null ? {} : { (tag.name) : trimspace(replace(local.tag_lookups[tag.value], local.tag_regex, local.defaults.replacement)) })],
      [for tag in local.friendly_name_tags : (lookup(local.tag_lookups, tag.value, null) == null ? {} : { (tag.name) : trimspace(replace(local.tag_lookups[tag.value], local.tag_regex, local.defaults.replacement)) })],
    )
  )
  tags_known = zipmap(
    flatten(
      [for item in local._tags_known : keys(item)]
    ),
    flatten(
      [for item in local._tags_known : values(item)]
    )
  )

  _common_tags = [for tag in local.resource_tags : { (tag.name) : ((tag.pass_context && try(regex(local.regex.friendly_name), null) == null) ? lookup(local.tags, tag.name, null) : null) }]
  common_tags = zipmap(
    flatten(
      [for item in local._common_tags : keys(item)]
    ),
    flatten(
      [for item in local._common_tags : values(item)]
    )
  )

  _unique_tags = [for tag in local.resource_tags : { (tag.name) : ((!tag.pass_context && try(regex(local.regex.friendly_name), null) == null) ? lookup(local.tags, tag.name, null) : null) }]
  unique_tags = zipmap(
    flatten(
      [for item in local._unique_tags : keys(item)]
    ),
    flatten(
      [for item in local._unique_tags : values(item)]
    )
  )
  gcp_labels = {
    for key, value in local.tags : lower(key) => (length(value) < 63 ? lower(replace(replace(value, "/[ :]/", "-"), "/[./@]/", "_")) :
      substr(lower(replace(replace(value, "/[ :]/", "-"), "/[./@]/", "_")), 0, 63)
    )
  }
}
