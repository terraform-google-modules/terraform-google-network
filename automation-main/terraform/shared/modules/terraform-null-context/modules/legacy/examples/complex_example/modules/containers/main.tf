/*
  Description: Example Containers Modules
  Comments:
    - N/A
*/

module "base_context" {
  source = "../../../../"

  context = var.context

  module         = "example-containers-module"
  module_version = "13.0.1"

  module_values = {
    kv = {
      vm_product_cluster = "example-cluster"
      vm_platform        = "linux"
      vm_product_name    = "docker"
      vm_product_version = "19.0.1"
      name               = "hashcat"
    }
    tags = [{
      name     = "ClusterIdentifier"
      value    = "cluster_identifier"
      required = false
    }]
    locals = {
      cluster_count = min(
        var.context.custom_values.locals.max_container_count,
        var.context.environment_values.locals.max_container_count
      )
    }
  }
  name_prefix = "docker"
}


module "context_container" {
  count  = module.base_context.module_values.locals.cluster_count
  source = "../../../../"

  context = module.base_context.context

  provision_date = module.base_context.provision_date
  label_order    = concat(module.base_context.label_order, ["cluster_identifier"])
  description    = "Docker Hashcat Container ${count.index + 1}/${module.base_context.module_values.locals.cluster_count}"
  custom_values = {
    tags   = null
    locals = null
    kv = {
      cluster_identifier = count.index + 1
    }
  }
}

locals {
  mock_containers = [for c in module.context_container : {
    name        = c.name
    description = c.description
    tags        = c.tags
  }]
}
