/*
  Description: Example outputs
  Comments:
    - N/A
*/

output "base_context" {
  value = {
    tags            = module.base_context.tags
    resource_prefix = module.base_context.name_prefix
  }
}

output "example_resource" {
  value = {
    properties      = data.null_data_source.root_resource_1.outputs
    tags            = module.context_root_resource_1.tags
    allowed_subnets = module.context_root_resource_1.custom_values.locals.office_subnets
  }
}

output "example_containers" {
  value = module.containers_module.containers
}

output "binaries_storage" {
  value = module.binaries_storage.binaries_storage
}

output "client_dev_instance" {
  value = module.binaries_storage.dev_instance
}

output "dev_module_instance" {
  value = module.dev_module.instance
}
