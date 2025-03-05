/*
  Description: Customer EFS Terraform file; This terraform file creates EFS storage and mount targets.
  Comments:
    EFS:
      customer_usr_sap_trans
*/

##### customer_usr_sap_trans
resource "aws_efs_file_system" "customer_usr_sap_trans" {
  encrypted                       = true
  throughput_mode                 = var.custom_efs_throughput_mode
  provisioned_throughput_in_mibps = var.custom_efs_throughput_mode == "provisioned" ? var.custom_efs_throughput_in_mibps : null


  lifecycle_policy {
    transition_to_ia = "AFTER_90_DAYS"
  }
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-usr-sap-trans"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} /usr/sap/trans"
  })
  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

resource "aws_efs_mount_target" "customer_usr_sap_trans" {
  for_each       = local.subnet_primary_landscape_map
  file_system_id = aws_efs_file_system.customer_usr_sap_trans.id
  subnet_id      = aws_subnet.customer_subnets[each.key].id
  security_groups = [
    aws_security_group.customer_vpc.id
  ]
}
##### End customer_usr_sap_trans

##### ha_app
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
  for_each       = var.deploy_ha_efs ? local.subnet_primary_landscape_map : {}
  file_system_id = aws_efs_file_system.ha_app[0].id
  subnet_id      = aws_subnet.customer_subnets[each.key].id
  security_groups = [
    aws_security_group.customer_vpc.id,
    aws_security_group.customer_all_egress.id,
    aws_security_group.customer_access_management.id,
  ]
}
##### End ha_app