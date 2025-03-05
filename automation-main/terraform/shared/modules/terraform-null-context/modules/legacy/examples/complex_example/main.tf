/*
  Description: main.tf for complex example.
  Comments:
    - N/A
*/


module "base_context" {
  source = "../../"

  context = var.context

  module         = "example-root-module"
  module_version = "1.0.0"

  flags = {
    reset_module_values = true
  }

  custom_values = {
    locals = {
      office_subnets      = ["192.168.1.1/24", "10.0.0.1/24"]
      max_container_count = 5
    }
    kv   = null
    tags = null
  }

  module_values = {
    kv = {
      module_owner = "c5309336"
    }
    tags = [{
      name     = "ModuleOwner"
      value    = "module_owner"
      required = false
    }]
    locals = null
  }
}

module "context_root_resource_1" {
  source = "../../"

  context     = module.base_context.context
  name        = "root-module-cloud-storage"
  description = "Cloud storage bucket for root module"
}

data "null_data_source" "root_resource_1" {
  inputs = {
    name        = module.context_root_resource_1.name
    description = module.context_root_resource_1.description
  }
}

module "containers_module" {
  source = "./modules/containers"

  context = module.base_context.context
}

module "binaries_storage" {
  source = "./modules/client_storage"

  context = module.base_context.context
}

module "dev_module" {
  source = "./modules/dev_module"

  context = module.base_context.context
}
