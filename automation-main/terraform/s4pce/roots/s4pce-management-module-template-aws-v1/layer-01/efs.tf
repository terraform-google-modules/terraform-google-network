/*
  Description: Customer EFS Terraform file
  Comments: This terraform file creates EFS storage and mount targets.
*/


resource "aws_efs_file_system" "common_staging" {
  encrypted                       = true
  throughput_mode                 = var.adv_efs_staging_throughput_mode
  provisioned_throughput_in_mibps = var.adv_efs_staging_throughput_mode == "provisioned" ? var.adv_efs_staging_provisioned_throughput_in_mibps : null
  lifecycle_policy {
    transition_to_ia = "AFTER_60_DAYS"
  }
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-common-efs-staging"
    Description = "Common EFS for staging volume"
  })
}

resource "aws_efs_mount_target" "common_staging_1a" {
  file_system_id = aws_efs_file_system.common_staging.id
  subnet_id      = local.layer_00_outputs.subnet_main01_infrastructure_1a.id
  security_groups = [
    local.layer_00_outputs.security_group_main01_efs_common.id,
    local.layer_00_outputs.security_group_main01_all_egress.id,
  ]
}
resource "aws_efs_mount_target" "common_staging_1b" {
  file_system_id = aws_efs_file_system.common_staging.id
  subnet_id      = local.layer_00_outputs.subnet_main01_infrastructure_1b.id
  security_groups = [
    local.layer_00_outputs.security_group_main01_efs_common.id,
    local.layer_00_outputs.security_group_main01_all_egress.id,
  ]
}
resource "aws_efs_mount_target" "common_staging_1c" {
  file_system_id = aws_efs_file_system.common_staging.id
  subnet_id      = local.layer_00_outputs.subnet_main01_infrastructure_1c.id
  security_groups = [
    local.layer_00_outputs.security_group_main01_efs_common.id,
    local.layer_00_outputs.security_group_main01_all_egress.id,
  ]
}
