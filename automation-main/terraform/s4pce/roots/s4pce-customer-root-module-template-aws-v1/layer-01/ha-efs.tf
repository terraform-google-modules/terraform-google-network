/*
  Description: Customer EFS Terraform file; This terraform file creates EFS storage and mount targets.
  Layer: 01
  Dependencies:
  layer-00: subnets
  Comments:
*/


resource "aws_efs_file_system" "ha_app" {
  count           = var.deploy_ha_efs ? 1 : 0
  encrypted       = true
  throughput_mode = "elastic"
  lifecycle_policy {
    transition_to_ia = "AFTER_60_DAYS"
  }
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-ha-app"
    Description = "EFS for HA"
  })
}

resource "aws_efs_mount_target" "ha_app" {
  for_each       = var.deploy_ha_efs ? toset(["subnet_production_1a", "subnet_production_1b", "subnet_production_1c"]) : []
  file_system_id = aws_efs_file_system.ha_app[0].id
  subnet_id      = local.layer_00_outputs.infrastructure[each.value].id
  security_groups = [
    local.layer_00_outputs.infrastructure.security_group_vpc.id,
    local.layer_00_outputs.infrastructure.security_group_all_egress.id,
    local.layer_00_outputs.infrastructure.security_group_customer_access_management.id,
  ]
}

output "efs_ha_app" { value = var.deploy_ha_efs ? {
  id = aws_efs_file_system.ha_app[0].id
  ip_address = { for key, value in aws_efs_mount_target.ha_app :
    key => value.ip_address
} } : null }
