/*
  Description: Create Virtual Machines in the customer VNet
  Comments:
    Deployed Instances:
      Refer to instance.auto.tfvars
*/

locals {
  # Grabs the unique subnet key names from layer-00
  subnet_keys = keys(local.layer_00.infrastructure.subnets)
  # This formats the landscape value to be used for other variables
  instance_list_exclude_windows_and_saprouter = {
    for key, value in var.instance_list : key => value if !((lookup(value, "os", "") == "windows") || (lookup(value, "productname", "") == "router"))
  }

  # Determine what az the instance "wants" to be in.
  instance_list_want_az = {
    for key, value in var.instance_list : key => lookup(
      value, "az", local.instance_list_want_subnet[key].zone
    )
  }

  # Determine what subnet "wants" to be in.
  instance_list_want_subnet = {
    for key, value in var.instance_list : key => contains(local.subnet_keys,
      # Is subnet or landscape defined in the existing subnet keys?
    lookup(value, "subnet", lower(var.instance_list[key].landscape))) ?
    local.layer_00.infrastructure.subnets[lower(lookup(value, "subnet", lower(var.instance_list[key].landscape)))] :
    # Else, is the landscape quality_assurance or development?
    contains(["quality_assurance", "development"], lower(var.instance_list[key].landscape)) ?
    # Then use the default subnet.
    local.layer_00.infrastructure.subnets[var.default_subnet] :
    # Otherwise Error out.
    { Error = "Unknown Subnet/Zone Assignment" }
  }



  # Compiles necessary metadata for each instance based on provided criteria
  instance_list_metadata = {
    for key, value in var.instance_list : key => {
      # determine which context to use for each VM
      context_module = module.context_vm[lookup(value, "os", "rhel")]
      # determine which subnet to deploy the VM into based on its landscape and az
      subnet = local.instance_list_want_subnet[key].zone == local.instance_list_want_az[key] ? local.instance_list_want_subnet[key] : { Error = "Unknown Subnet/Zone Assignment" }
      # construct the Description tag for each VM
      description = "${module.layer_context.environment_values.kv.prefix_friendly_name} ${value.landscape} ${value.productgroup} ${value.productname} ${value.name}"
      # use the dictionary 'key' for the hostname unless specified otherwise
      hostname = lookup(value, "hostname", key)
      # use appropriate image variant
      image = lookup(value, "image", lower(value.name) == "db" ? var.image_database_name : var.image_application_name)
      # determine OS-disk storage account type
      disk_type = lookup(value, "disk_type", lower(value.name) == "db" ? "Premium_LRS" : "Standard_LRS")
    }
  }
}

module "context_instance_list" {
  source   = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  for_each = var.instance_list

  context = local.instance_list_metadata[each.key].context_module.context

  # Tagging Variables
  environment = title(each.value.landscape)
  additional_tags = merge(local.instance_list_metadata[each.key].context_module.additional_tags, {
    Name             = lower(each.value.name)
    Sid              = upper(each.value.sid)
    ProductName      = title(each.value.productname)
    ProductGroup     = title(each.value.productgroup)
    ProductComponent = lower(each.value.tag_productcomponent)
    Node             = upper(each.value.name)
    Description      = title(local.instance_list_metadata[each.key].description)
    Hostname         = lower(local.instance_list_metadata[each.key].hostname)
  })
}

module "instance_list" {
  source   = "EXAMPLE_SOURCE/terraform/shared/modules/azure-linux-virtual-machine"
  for_each = local.instance_list_exclude_windows_and_saprouter
  context  = module.context_instance_list[each.key].context
  ### MANDATORY values. These must be specified when calling module
  name                      = lower(each.key)
  location                  = local.layer_00.infrastructure.resource_group_customer.location
  resource_group_name       = local.layer_00.infrastructure.resource_group_customer.name
  search_image_name         = local.instance_list_metadata[each.key].image
  image_resource_group_name = local.layer_00.golden_image_resource_group
  public_key                = local.layer_00.ssh_customer_public_key
  subnet_id                 = local.instance_list_metadata[each.key].subnet.id
  zone                      = local.instance_list_metadata[each.key].subnet.zone
  ### Optional values. Values specified below have defaults or will be ignored if not passed by calling module.
  size                                 = each.value.instance_type
  application_security_groups          = local.layer_00.infrastructure.vm_base_security_groups
  system_assigned_identity_permissions = local.layer_01.vm_base_roles
  os_disk_storage_account_type         = local.instance_list_metadata[each.key].disk_type
  # DNS Variables
  dns_associate_private_ip_address = local.layer_00.infrastructure.private_dns_enabled
  dns_zone                         = lookup(local.layer_00.infrastructure, "private_dns_zone", null)
  dns_associate_cname              = true
  dns_additional_cnames            = concat(lookup(each.value, "cnames", []), [])
}
