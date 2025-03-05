/*
  Description: Create EFS Access Points
*/


module "context_access_point" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "access-point"
  description = "${module.base_layer_context.customer} EFS Access Points"
}

resource "aws_efs_access_point" "customer_interface" {
  for_each       = var.access_points
  file_system_id = local.layer_00_outputs.infrastructure.efs_usr_sap_trans.id
  dynamic "posix_user" {
    for_each = each.value.posix_user == null ? [] : ["posix_user"]
    content {
      uid = each.value.posix_user.uid
      gid = each.value.posix_user.gid
    }
  }
  dynamic "root_directory" {
    for_each = each.value.root_directory == null ? [] : ["root_directory"]
    content {
      path = each.value.root_directory.path
      dynamic "creation_info" {
        for_each = each.value.root_directory.creation_info == null ? [] : ["creation_info"]
        content {
          owner_gid   = each.value.root_directory.creation_info.owner_gid
          owner_uid   = each.value.root_directory.creation_info.owner_uid
          permissions = each.value.root_directory.creation_info.permissions
        }
      }
    }
  }
  tags = merge(module.context_access_point.tags, {
    Name = "${module.context_access_point.resource_prefix}-datasync-source"
  })
}
