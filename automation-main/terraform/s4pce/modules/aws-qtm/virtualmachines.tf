/*
  Description: QTM Instances, always deployed as set of 3
  Comments:
    - We should replace this code with custom code.
    - Most of the present code is trying to adapt the shared aws-instance to what is needed.
      or to compensate for the lack of flexibility in the shared module.
*/

locals {
  vm_pre_list = merge({
    for key, value in var.vm_values : key => {
      Description = "qtm_hana",
      ProductName = "ibp",
      nodetype    = "db",
      ami         = coalesce(value.ami_name, var.adv_image_database.name)
      owner       = coalesce(value.ami_owner, var.adv_image_database.owner)
    } if key == "qtm_database" }, {
    for key, value in var.vm_values : key => {
      Description = "qtm_abap"
      ProductName = "ibp",
      nodetype    = "app",
      ami         = coalesce(value.ami_name, var.adv_image_application.name)
      owner       = coalesce(value.ami_owner, var.adv_image_application.owner)
    } if key == "qtm_application" }, {
    for key, value in var.vm_values : key => {
      Description = "qtm_wdisp"
      ProductName = "ibp",
      nodetype    = "app",
      ami         = coalesce(value.ami_name, var.adv_image_application.name)
      owner       = coalesce(value.ami_owner, var.adv_image_application.owner)
  } if key == "qtm_webdispatcher" }, )
}
resource "random_id" "vm_name" {
  for_each    = var.vm_values
  byte_length = 8
  keepers = {
    meta_key_name = each.value.meta_key_name
    # Set once and ignore further changes
    meta_image_name  = local.vm_pre_list[each.key].ami
    meta_image_owner = local.vm_pre_list[each.key].owner
    build_user       = var.build_user
  }
  lifecycle {
    ignore_changes = [
      keepers["meta_image_name"],
      keepers["meta_image_owner"],
      keepers["build_user"],
    ]
  }
}

locals {
  # Combined Tags format as follows:
  # merge(  {Preset Tags, can be overwritten},
  #         {Additional Tags from user},
  #         {Meta Generated Tags, cannot be overwritten})
  vm_list = {
    for key, value in var.vm_values : key => {
      instance_type = value.instance_type
      combined_tags = merge({
        Description = local.vm_pre_list[key].Description
        ProductName = local.vm_pre_list[key].ProductName
        Name        = "${local.vm_pre_list[key].nodetype}/${random_id.vm_name[key].hex}"
        },
        var.tags,
        var.vm_values[key].additional_tags, {
          meta_node_type   = local.vm_pre_list[key].nodetype
          meta_key_name    = random_id.vm_name[key].keepers.meta_key_name
          meta_image_name  = random_id.vm_name[key].keepers.meta_image_name
          meta_image_owner = random_id.vm_name[key].keepers.meta_image_owner
          BuildUser        = random_id.vm_name[key].keepers.build_user
          ProvisionDate    = time_static.module.rfc3339
  }) } }
}



module "instance_list" {
  for_each = local.vm_list
  source   = "../../../shared/modules/aws-instance"
  # Using the pre_list instead of random_id metadata because the metadata is historical.
  search_ami_name            = local.vm_pre_list[each.key].ami
  search_ami_owner_id        = local.vm_pre_list[each.key].owner
  instance_type              = lower(each.value.instance_type)
  ec2_key                    = var.ec2_key
  monitoring                 = false
  root_encrypted             = true
  root_delete_on_termination = true
  enable_state_recovery      = false
  source_dest_check          = true
  security_group_ids = concat(
    [aws_security_group.qtm_instance.id],
    var.vm_values[each.key].additional_security_group_ids,
  )
  subnet_id                            = var.subnet_info.id
  iam_instance_profile                 = var.iam_instance_profile
  aws_region                           = var.context.region
  context                              = var.context
  tag_productname                      = each.value.combined_tags.ProductName
  tag_name                             = each.value.combined_tags.meta_node_type
  tag_description                      = each.value.combined_tags.Description
  route53_associate_private_ip_address = false
  # route53_zoneid                       = local.layer_00_outputs.infrastructure.route53_zone.id
  # route53_associate_cname              = true
  # route53_additional_cnames            = concat(lookup(each.value, "cnames", []), [])
}


output "virtual_machines" {
  description = "QTM Virtual Machines"
  value       = module.instance_list
}
