/*
  Description: Null-Context Variables
*/
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
    partition              = string
    parent_module          = string
    parent_module_version  = string
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
    partition              = null
    parent_module          = null
    parent_module_version  = null
    regex_replace_chars    = null
    region                 = null
    resource_tags          = null
    root_module            = null
    security_boundary      = null
  }
}
