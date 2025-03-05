/*
  Description: Logic for making resource labels.
  Comments:
    - N/A
*/

locals {
  labels = {
    customer      = "customer"
    name_prefix   = "name_prefix"
    friendly_name = "friendly_name"
    product_name  = "vm_product_name"
    account_tag   = "Account"
    flags = {
      reset_environment_values = "reset_environment_values"
      reset_modules_values     = "reset_module_values"
      reset_custom_values      = "reset_custom_values"
      use_org_prefix           = "use_org_prefix"
      use_unique_name          = "use_unique_name"
      skip_checks              = "skip_checks"
      override_name            = "override_name"
      name_from_resource       = "name_from_resource"
      exclude_name_prefix      = "exclude_name_prefix"
      is_s3_bucket             = "is_s3_bucket"
    }
  }
  regex = {
    friendly_name = "_friendly_name$"
  }

  # Generate a list of attributes to use for the resource label.
  # Resource labels always get the deploy prefix if set, after the deploy prefix it will select the none-null label
  # context values in the order specified in the label order variable.
  resource_label_attributes_list = concat(
    [for l in local.label_order : local.lookup_map[l] if local.lookup_map[l] != null],
    (local.name_prefix == null || local.exclude_name_prefix == true) ? [] : [local.name_prefix]
  )

  # We then take the resource_label_attributes_list and check to see if there are at least 1 value in it.
  # If there are not, then set resource_label_attributes to null else use the output from above.
  # NOTE: By setting this to null, terraform will have an error in planning on the next line, this
  # is how this is intended to work. If there are less than two elements then the resource name will not be descriptive
  # enough.
  _resource_label_attributes_check = join(local.delimiter, (local.skip_checks == true || local.is_s3_bucket == true) ? [] : length(local.resource_label_attributes_list) >= 1 ? [for l in local.resource_label_attributes_list : l if l != null] : local.defaults.errors.ERROR_LESS_THAN_ONE_LABEL_ELEMENT)
  # Join those attributes together with the delimiter to make the resource prefix.
  resource_prefix     = join(local.delimiter, local.resource_label_attributes_list)
  exclude_name_prefix = lookup(local.flags, local.labels.flags.exclude_name_prefix, local.defaults.flags.exclude_name_prefix)
  # If a name was provided, then make the resource name by appending it with the delimiter to the resource prefix.
  _resource_name = local.override_name == true ? local.name : local.name == null ? null : (
    join(local.delimiter,
      compact(
        [
          local.use_org_prefix ? local.organization : "",
          local.resource_prefix,
          local.name,
          local.use_unique_name ? local.environment_salt : ""
        ]
      )
    )
  )
  resource_name = local.is_s3_bucket == true ? join(local.delimiter, [local.organization, local._resource_name]) : local._resource_name



  _resource_name_length_check = (local.skip_checks == true || local.resource_name == null) ? "CHECK SKIPPED" : join("", length(local.resource_name) > 127 ? [local.defaults.errors.ERROR_RESOURCE_NAME_IS_TOO_LONG] : ["CHECK PASSED"])

  # Sometimes the name is too long for resource naming limits. So we also create a short prefix and a short name.
  # The short prefix takes the deploy prefix and then the first 4 chars of each of the lookup_map values.
  short_resource_label_attributes = concat(
    [
      for l in local.label_order :
      substr(local.lookup_map[l], 0, 4) if local.lookup_map[l] != null
    ]
  )
  _short_resource_prefix_check = join(local.delimiter, (local.skip_checks == true || local.is_s3_bucket == true) ? [] : length(local.short_resource_label_attributes) >= 1 ? local.short_resource_label_attributes : [local.defaults.errors.ERROR_LESS_THAN_ONE_LABEL_ELEMENT])
  short_resource_prefix        = join(local.delimiter, local.short_resource_label_attributes)

  # The short name is a max of 32 chars long. The short name takes the short prefix, and trims the beginning of the
  # name until its a combined total of 32 chars.
  _name_length       = local.name == null ? 0 : length(local.name)
  __short_name_start = (local._name_length - (local.defaults.short_max_length - length(local.short_resource_prefix)))
  _short_name_start  = local.__short_name_start < 0 ? 0 : local.__short_name_start + 1
  _short_name_end    = local.defaults.short_max_length - length(local.short_resource_prefix)
  short_resource_name = local.name == null ? null : join(
    local.delimiter,
    [
      local.short_resource_prefix,
      local.name == null ? "" : substr(local.name, local._short_name_start, local._name_length)
    ]
  )
}
