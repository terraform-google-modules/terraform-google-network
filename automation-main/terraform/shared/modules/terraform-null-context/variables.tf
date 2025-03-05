/*
  Description: Inputs for context module
  Comments:
    - N/A
*/

variable "account_id" {
  default     = null
  description = "What is the AWS account ID for this resource"
  type        = string
}
variable "additional_tags" {
  default     = null
  description = "Additional tags to add to resources."
  type        = map(string)
}

variable "build_user" {
  default     = null
  description = "BuildUser, the user who deployed this resource."
  type        = string
}

variable "business" {
  default     = null
  description = "Business, a way to identify the org that the resource belongs to. (i.e. `sap`, `ns2`, `cre`)"
  type        = string
}

variable "custom_values" {
  default     = null
  description = "Custom Values, extra variables to carry with the context. They can be access for labels or tags."
  type = object({
    kv     = map(string)
    locals = any
    tags = list(object({
      name     = string
      required = bool
      value    = string
    }))
  })
}

# TODO: Change to billing customer
variable "customer" {
  default     = null
  description = "Customer, who is this resource for."
  type        = string
}

variable "delimiter" {
  default     = null
  description = "Delimiter to use for resource prefix etc. (default: `-`)"
  type        = string
}

variable "dependencies" {
  default     = null
  description = "Dependencies, What does this resource depend on? This is not passed out in `context`"
  type        = list(string)
}

variable "description" {
  default     = null
  description = "Description, description of the resource, used for tagging."
  type        = string
}

variable "environment" {
  default     = null
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'build'"
  type        = string
}

variable "environment_salt" {
  description = "Environment Salt, this should be 8 hex characters."
  default     = null
  type        = string
}
variable "environment_values" {
  default     = null
  description = "Values to pass to any context module in the same environment."
  type = object({
    kv     = map(string)
    locals = any
    tags = list(object({
      name     = string
      required = bool
      value    = string
    }))
  })
}

variable "flags" {
  description = "Optional flags for different settings"
  type        = map(bool)
  default = {
    reset_custom_values      = null
    reset_environment_values = null
    reset_module_values      = null
    skip_checks              = null
    use_org_prefix           = null
    use_unique_name          = null
    exclude_name_prefix      = null
    is_s3_bucket             = null
  }
}

variable "generated_by" {
  default     = null
  description = "Generated-By, How was this deployment generated. (default: `terraform`)"
  type        = string
}

variable "include_customer_label" {
  default     = null
  description = "If set to true, include customer in the label"
  type        = bool
}

variable "label_order" {
  default     = null
  description = "The order of labels for naming prefix."
  type        = list(string)
}

variable "local_kv" {
  default     = null
  description = "Local Key/Value map that is not passed out in context. This is only for this context instance. (KV values can be used for tags and labels)"
  type        = map(string)
}

variable "managed_by" {
  default     = null
  description = "Managed-By, How is this deployment managed. (default: `terraform`)"
  type        = string
}

variable "module" {
  default     = null
  description = "Module, What module was this deployed from."
  type        = string
}

variable "module_values" {
  default     = null
  description = "Custom values to only be used within the same module."
  type = object({
    kv     = map(string)
    locals = any
    tags = list(object({
      name     = string
      value    = string
      required = bool
    }))
  })
}

variable "module_version" {
  default     = null
  description = "ModuleVersion, What version of the module was this deployed from."
  type        = string
}

variable "name" {
  default     = null
  description = "Name, name of the resource. (Optional)"
  type        = string
}

variable "name_prefix" {
  default     = null
  description = "A label to put before the name of the resource and after the standard labels"
  type        = string
}

variable "organization" {
  type        = string
  description = "Organization, usually `ns2`. This is used as a prefix to globally unique resources."
  default     = null
}

variable "owner" {
  default     = null
  description = "Owner, who is responsible for this deployment."
  type        = string
}

variable "partition" {
  description = "What AWS partition is this getting deployed in?"
  type        = string
  default     = null
}

variable "parent_module" {
  description = "Name of Terraform parent module responsible for invoking the module"
  type        = string
  default     = null
}

variable "parent_module_version" {
  description = "Version of Terraform parent module responsible for invoking the module"
  type        = string
  default     = null
}

variable "provision_date" {
  default     = null
  description = "ProvisionDate, i.e. today."
  type        = string
}

variable "regex_replace_chars" {
  default     = "/[^a-zA-Z0-9-]/"
  description = "Regex to replace chars with empty string in `business`, `environment`, `customer`, 'scan_group', 'owner`, `managed_by`, `generated_by`, `build_user` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed"
  type        = string
}

variable "region" {
  default     = null
  description = "What AWS region is this getting deployed in?"
  type        = string
}

variable "resource_tags" {
  default     = null
  description = "a list of tag objects"
  type = list(
    object({
      name         = string
      pass_context = bool
      required     = bool
      value        = string
    })
  )
}

variable "root_module" {
  description = "Name of Terraform environment root module responsible for provisioning resources"
  type        = string
  default     = null
}

variable "security_boundary" {
  default     = null
  description = "Security Boundary, cre, fedciv"
  type        = string
}
