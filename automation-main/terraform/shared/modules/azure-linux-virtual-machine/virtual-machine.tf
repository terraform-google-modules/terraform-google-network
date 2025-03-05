/*
  Description: Create Linux Virtual Machine
  Comments:
    - A random hex value is automatically appended to the name via the random_id resource
*/

### Find the latest image to build the instance
data "azurerm_image" "instance" {
  resource_group_name = var.image_resource_group_name
  name                = substr(var.search_image_name, -1, -1) == "*" ? null : var.search_image_name
  name_regex          = substr(var.search_image_name, -1, -1) == "*" ? var.search_image_name : null
  sort_descending     = substr(var.search_image_name, -1, -1) == "*" ? true : null
}

### Optional Bootstrap Variables
locals {
  bootstrap = var.bootstrap_enable ? (var.custom_bootstrap == "" ? base64encode(local.bootstrap_template) : var.custom_bootstrap) : null
  # Used only when bootstrap is enabled and 'custom_bootstrap' left empty:
  bootstrap_template_option = "bootstrap-linux.sh"
  git_repository_path       = var.git_repository_path != "" ? var.git_repository_path : "/tmp/temprepo"
  bootstrap_command = join("; ", flatten([
    for command in var.bootstrap_commands : [command]
  ]))
  bootstrap_template = templatefile("${path.module}/files/${local.bootstrap_template_option}", {
    # NOTE: not every input is needed for every bootstrap option, however, it does not hurt to pass extra as they simply will not be used
    git_repository         = var.git_repository,
    git_branch             = var.git_branch,
    git_repository_path    = local.git_repository_path,
    git_repository_cleanup = var.git_repository_cleanup,
    git_name               = var.git_name,
    git_token              = var.git_token,
    bootstrap_command      = local.bootstrap_command
  })
}

### Create Virtual Machine based on found image
locals {
  additional_cnames_join = length(var.dns_additional_cnames) > 0 ? join(" ", var.dns_additional_cnames) : null
  additional_tags = merge(
    var.dns_associate_private_ip_address == true ? {
      DNSZone = data.azurerm_private_dns_zone.instance[0].name
    } : {},
    var.dns_associate_private_ip_address == true && local.additional_cnames_join != null ? {
      Cnames = local.additional_cnames_join
    } : {}
  )
}

module "context_instance" {
  source  = "../terraform-null-context/modules/legacy"
  count   = local.context_passed ? 1 : 0
  context = module.module_context[0].context

  flags = { override_name = true }
  name  = random_id.instance.hex

  additional_tags = local.additional_tags
}

locals {
  tags = merge(
    {
      # Derived Tags
      Subscription  = data.azurerm_subscription.current.id
      Image         = data.azurerm_image.instance.id
      ProvisionDate = timestamp()
      GeneratedBy   = "terraform"
      # Optional Legacy Tags
      Description = var.tag_description
      ProductName = var.tag_productname
    },
    # Either-Or Tags (context or legacy)
    local.context_passed ? module.context_instance[0].tags : {
      BuildUser        = var.build_user
      Business         = var.tag_business
      Customer         = var.tag_customer
      Environment      = var.tag_environment
      ManagedBy        = var.tag_managedby
      Owner            = var.tag_owner
      PatchGroup       = var.tag_patchgroup
      Platform         = var.tag_platform
      ProductCluster   = var.tag_productcluster
      ProductComponent = var.tag_productcomponent
      ProductVendor    = var.tag_productvendor
      ProductVersion   = var.tag_productversion
    },
    # Override the `Name` tag to ensure presence of `/<RANDOM>` suffix
    #   Note: merge() function will always prioritize the later Name key
    {
      Name = random_id.instance.hex
    }
  )
}

resource "azurerm_linux_virtual_machine" "instance" {
  resource_group_name          = var.resource_group_name
  location                     = var.location
  name                         = replace(random_id.instance.hex, "/", "-")
  zone                         = var.zone == "No-Zone" ? null : var.zone
  size                         = var.size
  admin_username               = var.admin_username
  source_image_id              = data.azurerm_image.instance.id
  dedicated_host_id            = var.dedicated_host_id
  encryption_at_host_enabled   = var.encryption_at_host_enabled
  proximity_placement_group_id = var.proximity_placement_group_id
  availability_set_id          = var.zone == "No-Zone" ? var.availability_set_id : null
  custom_data                  = local.bootstrap
  tags                         = local.tags

  network_interface_ids = [
    azurerm_network_interface.instance.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
  }

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_size_gb
  }

  identity {
    type         = "SystemAssigned${local.user_assigned_identity}"
    identity_ids = var.user_managed_identity_ids
  }

  lifecycle {
    ignore_changes = [
      source_image_id,
      custom_data,
      tags,
      admin_ssh_key,
    ]
  }

  depends_on = [
    random_id.instance,
    azurerm_network_interface.instance
  ]
}


### Identity
locals {
  user_assigned_identity = length(var.user_managed_identity_ids) > 0 ? ", UserAssigned" : ""
}

resource "azurerm_role_assignment" "system_assigned_identity_permissions" {
  for_each = var.system_assigned_identity_permissions

  role_definition_name = each.key
  principal_id         = azurerm_linux_virtual_machine.instance.identity[0].principal_id
  scope                = each.value == "self" ? azurerm_linux_virtual_machine.instance.id : each.value
}
