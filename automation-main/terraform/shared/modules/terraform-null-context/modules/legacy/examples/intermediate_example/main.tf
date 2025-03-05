/*
  Description: Example context
  Comments:
    - N/A
*/

module "base_context" {
  source = "../../"

  context        = var.context
  module         = "example-module"
  module_version = "0.0.1"

  environment_values = {
    tags   = null
    locals = null
    kv = {
      customer_friendly_name = "SAP National Security Services, Inc."
    }
  }
}

module "context_storage" {
  source = "../../"

  context     = module.base_context.context
  name        = "storage-bucket"
  description = "Cloud Storage Bucket"
}

locals {
  storage_bucket = {
    name        = module.context_storage.name
    description = module.context_storage.description
    tags        = module.context_storage.tags
  }
}
