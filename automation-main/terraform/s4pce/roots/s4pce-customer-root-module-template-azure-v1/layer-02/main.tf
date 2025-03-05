/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
*/

### Core Data Resources
data "azurerm_subscription" "current" {}

### Context
locals {
  base_context = local.layer_00.base_context
}

module "layer_context" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context = local.base_context

  environment_values = {
    kv = {
      deployment_layer = var.deployment_layer
    }
    tags   = null
    locals = null
  }
}

locals {
  vm_contexts = {
    rhel = {
      patch_group = "TBD_rhel" #local.layer_01.ssm_management_patching.patch_groups.security.rhel
      platform    = "unlicensed"
    }
    ubuntu = {
      patch_group = "TBD_ubuntu" #local.layer_01.ssm_management_patching.patch_groups.security.ubuntu
      platform    = "unlicensed"
    }
    windows = {
      patch_group = "TBD_windows" #local.layer_01.ssm_management_patching.patch_groups.security.windows
      platform    = "licensed"
    }
  }
}

module "context_vm" {
  source   = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context  = module.layer_context.context
  for_each = local.vm_contexts

  environment_values = {
    kv = {
      managed_by  = "ansible"
      patch_group = each.value.patch_group
      platform    = each.value.platform
    }
    tags = [
      { name = "ManagedBy", value = "managed_by", required = true },
      { name = "PatchGroup", value = "patch_group", required = true },
      { name = "Platform", value = "platform", required = true }
    ]
    locals = null
  }
}

### Gloabl Local Variables
locals {
  az_letter_mapping = local.layer_00.az_letter_mapping
}
