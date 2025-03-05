/*
  Description: AWS instances terraform file
  Comments:
    TODO: Need to refactor this to an IBP Module and tie it to the ansible Role like PCE.
*/

module "context_instance_rhel" {
  source        = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    PatchGroup = local.management_layer_01_outputs.ssm_customer_rhel_general.patch_group
    Platform   = "unlicensed"
    ManagedBy  = "ansible"
  }
}
module "context_instance_windows" {
  source        = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
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
  source        = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context       = module.base_layer_context.context
  custom_values = module.base_layer_context.custom_values
  additional_tags = {
    PatchGroup = local.management_layer_01_outputs.ssm_customer_ubuntu_general.patch_group
    Platform   = "unlicensed"
    ManagedBy  = "ansible"
  }
}



locals {
  instance_map = { for key, value in var.instance_map : value.metadata_key => {
    search_ami_name           = value.image_type == "database" ? var.image_database_name : var.image_application_name
    search_ami_owner_id       = value.image_type == "database" ? var.image_database_owner : var.image_application_owner
    subnet_id                 = local.layer_00_outputs.infrastructure.subnets[value.subnet_lookup].id
    iam_instance_profile      = value.image_type == "database" ? local.layer_01_outputs.iam_role_customer_database_id : local.layer_01_outputs.iam_role_customer_ibpapp_id
    tag_name                  = value.tag_name
    tag_description           = value.tag_description
    tag_productname           = value.tag_name
    instance_type             = value.instance_type
    route53_additional_cnames = value.cnames
  } }
}



module "instance_map" {
  for_each            = local.instance_map
  source              = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  search_ami_name     = each.value.search_ami_name
  search_ami_owner_id = each.value.search_ami_owner_id
  ec2_key             = aws_key_pair.main01.key_name
  security_group_ids = [
    local.layer_00_outputs.infrastructure.security_group_access_management_id,
    local.layer_00_outputs.infrastructure.security_group_all_egress_id,
    local.layer_00_outputs.infrastructure.security_group_vpc_id
  ]
  subnet_id                            = each.value.subnet_id
  iam_instance_profile                 = each.value.iam_instance_profile
  aws_region                           = module.base_layer_context.region
  context                              = module.context_instance_rhel.context
  tag_name                             = each.value.tag_name
  tag_description                      = each.value.tag_description
  tag_productname                      = each.value.tag_productname
  instance_type                        = each.value.instance_type
  enable_state_recovery                = true
  monitoring                           = true
  root_encrypted                       = true
  root_delete_on_termination           = false
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.management_layer_00_outputs.route53_zone_main01.id
  route53_additional_cnames            = each.value.route53_additional_cnames
}

moved {
  from = module.instance_cpids
  to   = module.instance_map["instance_cpids"]
}
moved {
  from = module.instance_webdispatcher
  to   = module.instance_map["instance_webdispatcher"]
}
moved {
  from = module.instance_staging_ibpdb
  to   = module.instance_map["instance_staging_ibpdb"]
}

moved {
  from = module.instance_staging_ibpapp
  to   = module.instance_map["instance_staging_ibpapp"]
}
moved {
  from = module.instance_production_ibpdb
  to   = module.instance_map["instance_production_ibpdb"]
}
moved {
  from = module.instance_production_ibpapp
  to   = module.instance_map["instance_production_ibpapp"]
}
