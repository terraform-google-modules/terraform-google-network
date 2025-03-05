/*
  Description: Example of a module in test phase
  Comments:
    - N/A
*/

module "base_context" {
  source = "../../../../"

  context = var.context

  module         = "dev-module"
  module_version = "0.0.1"

  additional_tags = {
    TESTING = "this resource is a test resource deployed by ${var.context.build_user}"
  }
}


module "context_instance" {
  source = "../../../../"

  context     = module.base_context.context
  name        = "metasploit"
  description = "Instance develop and test metasploit packages"
  label_order = concat(["deploy_prefix"], var.context.label_order)
  custom_values = {
    tags   = null
    locals = null
    kv = {
      platform         = "Ubuntu"
      platform_version = "20.04"
      product_name     = "metasploit"
      deploy_prefix    = "test"
    }
  }
}

locals {
  instance = {
    name        = module.context_instance.name
    description = module.context_instance.description
    tags        = module.context_instance.tags
  }
}
