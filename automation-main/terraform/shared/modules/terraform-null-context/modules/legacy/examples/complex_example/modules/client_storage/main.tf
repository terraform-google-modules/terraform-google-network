/*
  Description: Example client storage example
  Comments:
    - N/A
*/

module "base_context" {
  source = "../../../../"

  context = var.context
}

module "context_storage_bucket_binaries" {
  source = "../../../../"

  context     = module.base_context.context
  customer    = module.base_context.kv_map.client_id
  label_order = concat(["business"], module.base_context.label_order)
  name        = "binaries"
  description = "Binary cloud storage for ${module.base_context.kv_map.client_id}"
}

module "context_client_dev_module" {
  source = "../../../../"

  context     = module.base_context.context
  customer    = module.base_context.kv_map.client_id
  label_order = concat(["business"], module.base_context.label_order)
}

module "client_dev_module" {
  source = "../dev_module"

  context = module.context_client_dev_module.context
}

locals {
  binaries_storage = {
    name        = module.context_storage_bucket_binaries.name
    description = module.context_storage_bucket_binaries.description
    tags        = module.context_storage_bucket_binaries.tags
  }
}
