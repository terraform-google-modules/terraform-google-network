/*
  Description: AWS instances terraform file; Creates the following instances in the customer VPC
  Comments:
    Deployed Instances:
      see instance.auto.tfvars
*/


module "context_instance_rhel" {
  source        = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    PatchGroup = local.management_layer_01_outputs.ssm_customer_rhel_general.patch_group
    Platform   = "unlicensed"
    ManagedBy  = "ansible"
  }
}
module "context_instance_windows" {
  source        = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    "PatchGroup"  = local.management_layer_01_outputs.ssm_customer_windows_general.patch_group
    Platform      = "licensed"
    ManagedBy     = "powershell"
    ProductVendor = "windows"
  }
}
module "context_instance_ubuntu" {
  source        = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    PatchGroup = local.management_layer_01_outputs.ssm_customer_ubuntu_general.patch_group
    Platform   = "unlicensed"
    ManagedBy  = "ansible"
  }
}


##### For Loop Created Instances
locals {
  ### Defaults for instance_list

  # Remove Special Instances from Instance List
  instance_list_standard = { for key, value in var.instance_list : key => value if !contains(["router"], value.productname) }

  # This formats the landscape value to be used for other variables
  instance_list_landscape_formatted = { for key, value in var.instance_list : key => replace(lower(value.landscape), "-", "_") }

  # This automatically determines the correct az based on landscape. (production = az1a, quality_assurance = az1b, development = az1c)
  instance_list_az = {
    for key, value in var.instance_list : key => lookup(
      value, "az", local.instance_list_landscape_formatted[key] == "production" ? "1a" :
      local.instance_list_landscape_formatted[key] == "quality_assurance" ? "1b" :
      local.instance_list_landscape_formatted[key] == "development" ? "1c" : "error"
    )
  }
}

module "context_instance_list" {
  for_each      = var.instance_list
  source        = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  custom_values = module.base_layer_context.custom_values

  # Choose the source context based on patch group os. (ubuntu, windows, rhel)
  context = lookup(each.value, "os", "rhel") == "ubuntu" ? module.context_instance_ubuntu.context : (
    lookup(each.value, "os", "rhel") == "windows" ? module.context_instance_windows.context : module.context_instance_rhel.context
  )

  # Tagging Variables
  # Use either landscape as environment unless otherwise specified.
  environment = title(lookup(each.value, "tag_landscape", each.value.landscape))
  additional_tags = merge(
    {
      Name             = lower(each.value.name)
      Sid              = upper(each.value.sid)
      ProductName      = title(each.value.productname)
      ProductGroup     = title(each.value.productgroup)
      ProductComponent = lower(each.value.tag_productcomponent)
      Node             = upper(each.value.name)
      Description      = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} ${each.value.landscape} ${each.value.productgroup} ${each.value.productname} ${each.value.name}")
      # Use the key as the hostname unless specified otherwise
      Hostname = lower(lookup(each.value, "hostname", each.key))
    },
    lookup(each.value, "tag_customdomain", "none") != "none" ? { CustomDomain = each.value.tag_customdomain } : {},
    lookup(each.value, "tag_customhostname", "none") != "none" ? { CustomHostname = each.value.tag_customhostname } : {},
  )
}

module "instance_list" {
  for_each = local.instance_list_standard
  source   = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"

  # Use default values unless specified otherwise
  search_ami_name            = lookup(each.value, "ami", lower(each.value.name) == "db" ? var.image_database_name : var.image_application_name)
  search_ami_owner_id        = lookup(each.value, "ami_owner", var.ami_owner_default)
  instance_type              = lower(each.value.instance_type)
  ec2_key                    = aws_key_pair.main01.key_name
  monitoring                 = true
  root_encrypted             = true
  root_delete_on_termination = false
  enable_state_recovery      = true
  source_dest_check          = contains(var.ha_instances, (each.key)) ? false : true
  security_group_ids = concat(lookup(each.value, "securitygroups", []), [
    local.layer_00_outputs.infrastructure.security_group_vpc.id,
    local.layer_00_outputs.infrastructure.security_group_all_egress.id,
    local.layer_00_outputs.infrastructure.security_group_customer_access_management.id,
  ])

  # Choose subnet based on landscape and az
  subnet_id                            = lookup(each.value, "subnet", local.layer_00_outputs.infrastructure["subnet_${local.instance_list_landscape_formatted[each.key]}_${local.instance_list_az[each.key]}"].id)
  iam_instance_profile                 = local.layer_01_outputs.iam_role_customer_default.id
  aws_region                           = module.context_instance_list[each.key].region
  context                              = module.context_instance_list[each.key].context
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.layer_00_outputs.infrastructure.route53_zone.id
  route53_associate_cname              = true
  route53_additional_cnames            = concat(lookup(each.value, "cnames", []), [])
}
##### End For Loop Created Instances
