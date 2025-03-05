/*
  Description: Customer EFS Terraform file; This terraform file creates EFS storage and mount targets.
  Comments: TODO,  move this to a module.
*/


locals {
  efs_subnet_info = { for key, value in var.efs_subnets : value => merge(
    local.layer_00_outputs.infrastructure.metadata.subnet_all_map[value],
    local.layer_00_outputs.infrastructure.subnets[value],
    { "metadata_key" = value },
  ) }
  efs_subnet_mounts = { for key, value in local.efs_subnet_info : value.zone => value.id }
}


resource "aws_efs_file_system" "customer_usr_sap_trans" {
  encrypted                       = true
  throughput_mode                 = "provisioned"
  provisioned_throughput_in_mibps = 4

  lifecycle_policy {
    transition_to_ia = "AFTER_60_DAYS"
  }
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-sap-trans-storage"
    Description = "usr-sap-trans storage"
  })
  lifecycle {
    prevent_destroy = false
  }
}

moved {
  from = aws_efs_mount_target.customer_usr_sap_trans_1a
  to   = aws_efs_mount_target.customer_usr_sap_trans["a"]
}
resource "aws_efs_mount_target" "customer_usr_sap_trans" {
  for_each       = local.efs_subnet_mounts
  file_system_id = aws_efs_file_system.customer_usr_sap_trans.id
  subnet_id      = each.value
  security_groups = [
    local.layer_00_outputs.infrastructure.security_group_vpc_id
  ]
}
