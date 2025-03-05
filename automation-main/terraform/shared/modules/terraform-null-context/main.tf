/*
  Description: Main terraform for context module.
  Comments:
    - N/A
*/

# Create a static timestamp from when the context module was created.
#   store non-changing BuildUser value along with timestamp to capture inital user that provisioned each resource

resource "time_static" "time" {
  triggers = {
    build_user = local.__build_user
  }
  lifecycle {
    ignore_changes = all
  }
}

locals {
  # All variables prefixed with `_` are used to not have to repeat logic.
  # All variables below use the same logic, so only items that differ will be documented.
  delimiter           = coalesce(var.delimiter, var.context.delimiter, local.defaults.delimiter)
  dependencies        = var.dependencies == null ? local.defaults.dependencies : var.dependencies
  regex_replace_chars = coalesce(var.regex_replace_chars, var.context.regex_replace_chars)
  provision_date      = coalesce(var.provision_date, time_static.time.rfc3339)

  # Pull out the flags here
  flags                    = { for key, val in var.flags : key => (val == null ? lookup(local.defaults.flags, key, null) : val) }
  reset_environment_values = lookup(local.flags, local.labels.flags.reset_environment_values, local.defaults.flags.reset_module_values)
  reset_module_values      = lookup(local.flags, local.labels.flags.reset_modules_values, local.defaults.flags.reset_module_values)
  reset_custom_values      = lookup(local.flags, local.labels.flags.reset_custom_values, local.defaults.flags.reset_custom_values)
  is_s3_bucket             = lookup(local.flags, local.labels.flags.is_s3_bucket, local.defaults.flags.is_s3_bucket)
  _skip_checks_1           = lookup(local.flags, local.labels.flags.skip_checks, local.defaults.flags.skip_checks)
  _skip_checks_2           = lookup(try(var.context.environment_values.locals.flags, local.flags), local.labels.flags.skip_checks, local.defaults.flags.skip_checks)
  _skip_checks_3           = lookup(try(var.environment_values.locals.flags, local.flags), local.labels.flags.skip_checks, local.defaults.flags.skip_checks)
  skip_checks              = local._skip_checks_1 || local._skip_checks_2 || local._skip_checks_3
  override_name            = lookup(local.flags, local.labels.flags.override_name, local.defaults.flags.override_name)
  name_from_resource       = lookup(local.flags, local.labels.flags.name_from_resource, local.defaults.flags.name_from_resource)

  # DECIDE IF WE SHOULD USE UNIQUE NAME
  use_unique_name = lookup(local.flags, local.labels.flags.use_unique_name, false)
  use_org_prefix  = lookup(local.flags, local.labels.flags.use_org_prefix, local.defaults.flags.use_org_prefix)

  # DECIDE TO INCLUDE CUSTOMER LABEL
  _include_customer_label = try(coalesce(var.include_customer_label, var.context.include_customer_label), null)
  include_customer_label  = local._include_customer_label == null ? !(local.customer == local.organization) : local._include_customer_label

  # DEFINE LABEL ORDER
  _label_order = coalesce(var.label_order, var.context.label_order, local.defaults.label_order)

  _label_customer_index = try(index(local._label_order, local.labels.customer), -1) > 0 ? index(local._label_order, local.labels.customer) : null
  _label_order_no_customer = local._label_customer_index != null ? concat(
    slice(local._label_order, 0, local._label_customer_index),
    slice(local._label_order, local._label_customer_index + 1, length(local._label_order))
  ) : local._label_order

  label_order = local.include_customer_label ? local._label_order : local._label_order_no_customer

  # GET MODULE VALUES
  _module_values = coalesce(
    var.module_values,
    var.context.module_values,
    local.defaults.values
  )

  module_values = local.reset_module_values == true ? coalesce(var.module_values, local.defaults.values) : (
    try(
      toset(values(local._module_values)) == toset([null]) ? local.defaults.values : local._module_values,
      local._module_values
    )
  )

  # GET CUSTOM VALUES
  _custom_values = coalesce(
    var.custom_values,
    var.context.custom_values,
    local.defaults.values
  )
  custom_values = local.reset_custom_values == true ? coalesce(var.custom_values, local.defaults.values) : (
    try(
      toset(values(local._custom_values)) == toset([null]) ? local.defaults.values : local._custom_values,
      local._custom_values
    )
  )

  # GET ENVIRONMENT VALUES
  var_environment_values         = coalesce(var.environment_values, local.defaults.values)
  var_context_environment_values = coalesce(var.context.environment_values, local.defaults.values)
  # kv and tags are merged together from existing context if defined
  # locals merge is attempted, but otherwise take passed values with prevedence over existing context if defined
  _environment_values = {
    kv   = merge(local.var_context_environment_values.kv, local.var_environment_values.kv)
    tags = concat(coalesce(local.var_context_environment_values.tags, []), coalesce(local.var_environment_values.tags, []))
    locals = try(
      merge(local.var_context_environment_values.locals, local.var_environment_values.locals), # try() allows for failed merge due to `any` type
      local.var_environment_values.locals != null ? local.var_environment_values.locals : local.var_context_environment_values.locals
    )
  }
  environment_values = local.reset_environment_values == true ? coalesce(var.environment_values, local.defaults.values) : (
    try(
      toset(values(local._environment_values)) == toset([null]) ? local.defaults.values : local._environment_values,
      local._environment_values
    )
  )

  input_values_lookup_map = merge(
    var.local_kv == null ? {} : var.local_kv,
    local.custom_values.kv == null ? {} : local.custom_values.kv,
    local.environment_values.kv == null ? {} : local.environment_values.kv,
    local.module_values.kv == null ? {} : local.module_values.kv
  )

  # PARTITION
  _partition       = coalesce(var.partition, var.context.partition, local.defaults.sentinel)
  _partition_check = local.skip_checks == true ? "SKIPPING CHECKS" : join("", [local._partition == local.defaults.sentinel ? local.defaults.errors.MISSING_PARTITION : local._partition])

  # ACCOUNT ID
  _account_id       = coalesce(var.account_id, var.context.account_id, local.defaults.sentinel)
  _account_id_check = local.skip_checks == true ? "SKIPPING CHECKS" : join("", [local._account_id == local.defaults.sentinel ? local.defaults.errors.MISSING_ACCOUNT_ID : local._account_id])

  # REGION
  _region       = coalesce(var.region, var.context.region, local.defaults.sentinel)
  _region_check = local.skip_checks == true ? "SKIPPING CHECKS" : join("", [local._region == local.defaults.sentinel ? local.defaults.errors.MISSING_ACCOUNT_REGION : local._region])

  # BUILD USER
  __build_user = replace(
    lower(
      # Use the first one of these variables that is not null or an empty string and convert to lowercase.
      coalesce(var.build_user, var.context.build_user, local.defaults.sentinel)
    ),
    # Replace any not valid characters with the default replacement value.
    local.regex_replace_chars,
    local.defaults.replacement
  )
  _build_user = try(time_static.time.triggers.build_user, local.__build_user)

  # BUSINESS
  _business = replace(
    lower(
      coalesce(var.business, var.context.business, local.defaults.sentinel)
    ),
    local.regex_replace_chars,
    local.defaults.replacement
  )

  # BUSINESS
  _organization = replace(
    lower(
      coalesce(var.organization, var.context.organization, local.defaults.organization)
    ),
    local.regex_replace_chars,
    local.defaults.replacement
  )

  # CUSTOMER
  _customer = replace(
    lower(
      coalesce(var.customer, var.context.customer, local.defaults.customer)
    ),
    local.regex_replace_chars,
    local.defaults.replacement
  )

  # DESCRIPTION
  # Description does not have to be only [a-z0-9\-], so we just take the first none-empty value
  _description = coalesce(var.description, lookup(local.input_values_lookup_map, "description", null), local.defaults.sentinel)

  # ENVIRONMENT
  _environment = replace(
    lower(
      coalesce(var.environment, var.context.environment, local.defaults.sentinel)
    ),
    local.regex_replace_chars,
    local.defaults.replacement
  )

  # GENERATED BY
  _generated_by = replace(
    lower(
      coalesce(var.generated_by, var.context.generated_by, local.defaults.sentinel)
    ),
    local.regex_replace_chars,
    local.defaults.replacement
  )

  # NAME PREFIX
  _name_prefix = replace(
    lower(
      coalesce(var.name_prefix, var.context.name_prefix, local.defaults.name_prefix)
    ),
    local.regex_replace_chars,
    local.defaults.replacement
  )

  # MANAGED BY
  _managed_by = replace(
    lower(
      coalesce(var.managed_by, var.context.managed_by, local.defaults.sentinel)
    ),
    local.regex_replace_chars,
    local.defaults.replacement
  )

  # MODULE
  _module = replace(
    lower(
      coalesce(var.module, var.context.module, local.defaults.sentinel)
    ),
    local.defaults.regex_replace_chars_extended,
    local.defaults.replacement
  )

  # MODULE VERSION
  _module_version = replace(
    lower(
      coalesce(var.module_version, var.context.module_version, local.defaults.sentinel)
    ),
    local.defaults.regex_replace_chars_extended,
    local.defaults.replacement
  )

  # PARENT MODULE
  _parent_module = local.reset_module_values == true ? null : var.context.parent_module != null ? var.context.parent_module : (
    replace(
      lower(
        var.module == null ? coalesce(var.context.parent_module, local.defaults.sentinel) : coalesce(var.context.module, local.defaults.sentinel)
      ),
      local.defaults.regex_replace_chars_extended,
      local.defaults.replacement
    )
  )

  # PARENT MODULE VERSION
  _parent_module_version = local.reset_module_values == true ? null : var.context.parent_module_version != null ? var.context.parent_module_version : (
    replace(
      lower(
        var.module_version == null ? coalesce(var.context.parent_module_version, local.defaults.sentinel) : coalesce(var.context.module_version, local.defaults.sentinel)
      ),
      local.defaults.regex_replace_chars_extended,
      local.defaults.replacement
    )
  )

  # ROOT MODULE
  _root_module = replace(
    lower(
      coalesce(var.root_module, var.context.root_module, local.defaults.sentinel)
    ),
    local.defaults.regex_replace_chars_extended,
    local.defaults.replacement
  )

  # NAME
  _name = replace(
    lower(
      coalesce(var.name, lookup(local.input_values_lookup_map, "name", null), local.defaults.sentinel)
    ),
    local.regex_replace_chars,
    local.defaults.replacement
  )

  # OWNER
  _owner = replace(
    lower(
      coalesce(var.owner, var.context.owner, local.defaults.sentinel)
    ),
    local.defaults.regex_replace_chars_extended,
    local.defaults.replacement
  )

  # SECURITY BOUNDARY
  _security_boundary = replace(
    lower(
      coalesce(var.security_boundary, var.context.security_boundary, local.defaults.sentinel)
    ),
    local.regex_replace_chars,
    local.defaults.replacement
  )


  # The following checks if the output from above is an empty string, then set to null, otherwise use the output value.
  account_id            = local._account_id == local.defaults.sentinel ? null : local._account_id
  build_user            = local._build_user == "" ? null : local._build_user
  business              = local._business == "" ? null : local._business
  customer              = local._customer == "" ? null : local._customer
  description           = local._description == local.defaults.sentinel ? null : local._description
  environment           = local._environment == "" ? null : local._environment
  generated_by          = local._generated_by == "" ? local.defaults.generated_by : local._generated_by
  managed_by            = local._managed_by == "" ? local.defaults.managed_by : local._managed_by
  module                = local._module == "" ? null : local._module
  module_version        = local._module_version == "" ? null : local._module_version
  name_prefix           = local._name_prefix == "" ? null : local._name_prefix
  owner                 = local._owner == "" ? null : local._owner
  organization          = local._organization == "" ? null : local._organization
  partition             = local._partition == local.defaults.sentinel ? null : local._partition
  parent_module         = local._parent_module == "" ? null : local._parent_module
  parent_module_version = local._parent_module_version == "" ? null : local._parent_module_version
  region                = local._region == local.defaults.sentinel ? null : local._region
  root_module           = local._root_module == "" ? null : local._root_module
  security_boundary     = local._security_boundary == local.defaults.sentinel ? null : local._security_boundary

  lookup_map = merge(
    local.defaults.kv,
    {
      description = local.description
    },
    local.context,
    local.input_values_lookup_map
  )

  _name_from_resource = local.name_from_resource == true ? (var.name == null ? "" : var.name) : ""
  __name_from_resource = regexall("(?:${
    coalesce(local.organization)
    }-)*?(?:${
    join(local.delimiter, [
      for l in local.label_order : local.lookup_map[l] if local.lookup_map[l] != null
    ])
    })-([a-z0-9-]+?)(?:$|-${local.environment_salt}$)",
    local._name_from_resource
  )
  ___name_from_resource = length(flatten(local.__name_from_resource)) == 0 ? null : join(local.delimiter, flatten(local.__name_from_resource))

  # SET THE NAME, EITHER FROM THE NAME PASSED IN OR FROM THE NAME FROM RESOURCE
  name = local.override_name == true ? var.name : (
    local.name_from_resource == true ? local.___name_from_resource : (
      local._name == "" ? null : local._name
    )
  )

  # Environment Salt is a random hex string to add to the end of S3 buckets or any resource that needs to be 100 unique.

  _environment_salt = coalesce(var.environment_salt, var.context.environment_salt, local.defaults.environment_salt)
  environment_salt  = (local._environment_salt == local.defaults.sentinel) && (local.account_id != null) ? substr(sha256(local.account_id), 0, 6) : local._environment_salt


  # This is for the output context into another context module.
  context = {
    account_id             = local.account_id
    additional_tags        = local.additional_tags
    build_user             = local.build_user
    business               = local.business
    custom_values          = local.custom_values
    customer               = local.customer
    delimiter              = local.delimiter
    environment            = local.environment
    environment_salt       = local.environment_salt
    environment_values     = local.environment_values
    generated_by           = local.generated_by
    include_customer_label = local.include_customer_label
    label_order            = local.label_order
    managed_by             = local.managed_by
    module                 = local.module
    module_values          = local.module_values
    module_version         = local.module_version
    name_prefix            = local.name_prefix
    organization           = local.organization
    owner                  = local.owner
    partition              = local.partition
    parent_module          = local.parent_module
    parent_module_version  = local.parent_module_version
    regex_replace_chars    = local.regex_replace_chars
    region                 = local.region
    resource_tags          = local.resource_tags
    root_module            = local.root_module
    security_boundary      = local.security_boundary
  }


  # Domain Label Mapping
  _parent_domain_internal = (
    can(lookup(local.context.environment_values.kv, "parent_domain_internal", null)) ? (
      lookup(local.context.environment_values.kv, "parent_domain_internal", null) != null ?
      local.context.environment_values.kv.parent_domain_internal :
      local.defaults.parent_domain_internal
    ) : local.defaults.parent_domain_internal
  )
  _parent_domain_external = (
    can(lookup(local.context.environment_values.kv, "parent_domain_external", null)) ? (
      lookup(local.context.environment_values.kv, "parent_domain_external", null) != null ?
      local.context.environment_values.kv.parent_domain_external :
      local.defaults.parent_domain_external
    ) : local.defaults.parent_domain_external
  )
  domain_label_mapping = {
    internal = {
      for label in local.label_order : label => join(".", concat(flatten([
        for inner_label in reverse(local.label_order) : [
          can(local.context[inner_label]) ? local.context[inner_label] : (
            can(lookup(local.context.environment_values.kv, inner_label, null)) ? (
              lookup(local.context.environment_values.kv, inner_label, null) != null ? local.context.environment_values.kv[inner_label] : ""
            ) : ""
          )
        ] if index(local.label_order, label) >= index(local.label_order, inner_label)
        ]), [
        local._parent_domain_internal
      ]))
    }
    external = {
      for label in local.label_order : label => join(".", concat(flatten([
        for inner_label in reverse(local.label_order) : [
          can(local.context[inner_label]) ? local.context[inner_label] : (
            can(lookup(local.context.environment_values.kv, inner_label, null)) ? (
              lookup(local.context.environment_values.kv, inner_label, null) != null ? local.context.environment_values.kv[inner_label] : ""
            ) : ""
          )
        ] if index(local.label_order, label) >= index(local.label_order, inner_label)
        ]), [
        local._parent_domain_external
      ]))
    }
  }
  domain = {
    internal        = local.domain_label_mapping.internal[local.label_order[length(local.label_order) - 1]]
    parent_internal = local._parent_domain_internal
    external        = local.domain_label_mapping.external[local.label_order[length(local.label_order) - 1]]
    parent_external = local._parent_domain_external
    label_mapping   = local.domain_label_mapping
  }


  # Prefix Label Mapping
  label_order_bottom = local.label_order[length(local.label_order) - 1]
  prefix_label_mapping = {
    bottom = {
      formatted = join(" ", flatten([
        for inner_label in local.label_order : [
          can(local.context["${inner_label}_formatted"]) ? local.context["${inner_label}_formatted"] : (
            can(lookup(local.context.environment_values.kv, "${inner_label}_formatted", null)) ? (
              lookup(local.context.environment_values.kv, "${inner_label}_formatted", null) != null ? local.context.environment_values.kv["${inner_label}_formatted"] : ""
            ) : ""
          )
        ] if index(local.label_order, local.label_order_bottom) >= index(local.label_order, inner_label)
      ]))
      friendly = join(" ", flatten([
        for inner_label in local.label_order : [
          can(local.context["${inner_label}_friendly_name"]) ? local.context["${inner_label}_friendly_name"] : (
            can(lookup(local.context.environment_values.kv, "${inner_label}_friendly_name", null)) ? (
              lookup(local.context.environment_values.kv, "${inner_label}_friendly_name", null) != null ? local.context.environment_values.kv["${inner_label}_friendly_name"] : ""
            ) : ""
          )
        ] if index(local.label_order, local.label_order_bottom) >= index(local.label_order, inner_label)
      ]))
      name = join(" ", flatten([
        for inner_label in local.label_order : [
          can(local.context[inner_label]) ? local.context[inner_label] : (
            can(lookup(local.context.environment_values.kv, inner_label, null)) ? (
              lookup(local.context.environment_values.kv, inner_label, null) != null ? local.context.environment_values.kv[inner_label] : ""
            ) : ""
          )
        ] if index(local.label_order, local.label_order_bottom) >= index(local.label_order, inner_label)
      ]))
    }
    formatted = {
      for label in local.label_order : label => join(" ", flatten([
        for inner_label in local.label_order : [
          can(local.context["${inner_label}_formatted"]) ? local.context["${inner_label}_formatted"] : (
            can(lookup(local.context.environment_values.kv, "${inner_label}_formatted", null)) ? (
              lookup(local.context.environment_values.kv, "${inner_label}_formatted", null) != null ? local.context.environment_values.kv["${inner_label}_formatted"] : ""
            ) : ""
          )
        ] if index(local.label_order, label) >= index(local.label_order, inner_label)
      ]))
    }
    friendly = {
      for label in local.label_order : label => join(" ", flatten([
        for inner_label in local.label_order : [
          can(local.context["${inner_label}_friendly_name"]) ? local.context["${inner_label}_friendly_name"] : (
            can(lookup(local.context.environment_values.kv, "${inner_label}_friendly_name", null)) ? (
              lookup(local.context.environment_values.kv, "${inner_label}_friendly_name", null) != null ? local.context.environment_values.kv["${inner_label}_friendly_name"] : ""
            ) : ""
          )
        ] if index(local.label_order, label) >= index(local.label_order, inner_label)
      ]))
    }
    name = {
      for label in local.label_order : label => join(" ", flatten([
        for inner_label in local.label_order : [
          can(local.context[inner_label]) ? local.context[inner_label] : (
            can(lookup(local.context.environment_values.kv, inner_label, null)) ? (
              lookup(local.context.environment_values.kv, inner_label, null) != null ? local.context.environment_values.kv[inner_label] : ""
            ) : ""
          )
        ] if index(local.label_order, label) >= index(local.label_order, inner_label)
      ]))
    }
    prefix = {
      for label in local.label_order : label => join("-", flatten([
        for inner_label in local.label_order : [
          can(local.context[inner_label]) ? local.context[inner_label] : (
            can(lookup(local.context.environment_values.kv, inner_label, null)) ? (
              lookup(local.context.environment_values.kv, inner_label, null) != null ? local.context.environment_values.kv[inner_label] : ""
            ) : ""
          )
        ] if index(local.label_order, label) >= index(local.label_order, inner_label)
      ]))
    }
  }
}
