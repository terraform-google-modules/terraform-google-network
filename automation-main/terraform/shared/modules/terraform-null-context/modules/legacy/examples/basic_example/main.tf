/*
  Description: Example context
  Comments:
    - N/A
*/

module "base_environment_context" {
  source = "../../"

  build_user             = "c5309336"
  business               = "Splunk"
  customer               = "customer-123456"
  environment            = "production"
  owner                  = "sapns2"
  security_boundary      = "cre"
  organization           = "ns2"
  partition              = "aws-us-gov"
  account_id             = "12345678"
  region                 = "us-gov-west-1"
  include_customer_label = false

  environment_values = {
    tags   = null
    locals = null
    kv = {
      security_boundary_friendly_name = "Commercial Regulated Environment"
    }
  }
}

module "base_context" {
  source = "../../"

  context = module.base_environment_context.context

  module         = "example-module"
  module_version = "0.0.1"

  name_prefix = "a"
}

module "context_storage" {
  source = "../../"

  context     = module.base_context.context
  name        = "storage-bucket"
  description = "Cloud Storage Bucket"


  flags = {
    use_unique_name = true
  }
}

locals {
  storage_bucket = {
    name        = module.context_storage.name
    description = module.context_storage.description
    tags        = module.context_storage.tags

  }
}
