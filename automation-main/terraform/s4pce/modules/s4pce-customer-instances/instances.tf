/*
  Description: AWS instances terraform file; Creates the following instances in the customer VPC
  Comments:
    Deployed Instances:
      see instance.auto.tfvars
*/

module "context_instance_rhel" {
  source        = "../../../shared/modules/terraform-null-context"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    PatchGroup = var.rhel_patch_group
    Platform   = "unlicensed"
    ManagedBy  = "ansible"
  }
}
module "context_instance_windows" {
  source        = "../../../shared/modules/terraform-null-context"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    "PatchGroup"  = var.windows_patch_group
    Platform      = "licensed"
    ManagedBy     = "powershell"
    ProductVendor = "windows"
  }
}
module "context_instance_ubuntu" {
  source        = "../../../shared/modules/terraform-null-context"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    PatchGroup = var.ubuntu_patch_group
    Platform   = "unlicensed"
    ManagedBy  = "ansible"
  }
}

##### For Loop Created Instances

module "context_instance_list" {
  for_each      = var.instance_list
  source        = "../../../shared/modules/terraform-null-context"
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
  source   = "../../../shared/modules/aws-instance"

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
  security_group_ids         = concat(lookup(each.value, "securitygroups", []), var.instance_security_groups_list)

  # Choose subnet based on landscape and az
  subnet_id                            = var.subnets[each.value.subnet_name].id
  iam_instance_profile                 = var.instance_iam_role
  aws_region                           = module.context_instance_list[each.key].region
  context                              = module.context_instance_list[each.key].context
  route53_associate_private_ip_address = true
  route53_zoneid                       = var.instance_route53_zone_id
  route53_associate_cname              = true
  route53_additional_cnames            = concat(lookup(each.value, "cnames", []), [])
}
#### End For Loop Created Instances
