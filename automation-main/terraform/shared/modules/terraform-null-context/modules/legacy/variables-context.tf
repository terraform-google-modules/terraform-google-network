/*
    Filename: variables-context.tf
    Description: Variable definition for context.
    Note: This is extracted from the variables file to be easily copied and updated
          in places that it is used. When updating this file, you must update every
          reference to it in the codebase.
*/
### Context
variable "context" {
  type = object({
    account_id             = string
    additional_tags        = map(string)
    build_user             = string
    business               = string
    customer               = string
    delimiter              = string
    environment            = string
    environment_salt       = string
    generated_by           = string
    include_customer_label = bool
    label_order            = list(string)
    managed_by             = string
    module                 = string
    module_version         = string
    name_prefix            = string
    organization           = string
    owner                  = string
    parent_module          = string
    parent_module_version  = string
    partition              = string
    regex_replace_chars    = string
    region                 = string
    root_module            = string
    security_boundary      = string

    custom_values = object({
      kv     = map(string)
      locals = any
      tags = list(object({
        name     = string
        value    = string
        required = bool
      }))
    })

    environment_values = object({
      kv     = map(string)
      locals = any
      tags = list(object({
        name     = string
        value    = string
        required = bool
      }))
    })

    module_values = object({
      kv     = map(string)
      locals = any
      tags = list(object({
        name     = string
        value    = string
        required = bool
      }))
    })

    resource_tags = list(
      object({
        name         = string
        value        = string
        required     = bool
        pass_context = bool
      })
    )

  })
  default = {
    account_id             = null
    additional_tags        = null
    build_user             = null
    business               = null
    custom_values          = null
    customer               = null
    delimiter              = null
    environment            = null
    environment_salt       = null
    environment_values     = null
    generated_by           = null
    include_customer_label = null
    label_order            = null
    managed_by             = null
    module                 = null
    module_values          = null
    module_version         = null
    name_prefix            = null
    organization           = null
    owner                  = null
    parent_module          = null
    parent_module_version  = null
    partition              = null
    regex_replace_chars    = null
    region                 = null
    resource_tags          = null
    root_module            = null
    security_boundary      = null
  }
}
