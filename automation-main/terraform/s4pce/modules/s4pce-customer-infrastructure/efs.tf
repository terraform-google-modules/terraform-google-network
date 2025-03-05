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
  provisioned_throughput_in_mibps = var.custom_efs_throughput_in_mibps

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
resource "aws_efs_mount_target" "customer_usr_sap_trans_1a" {
  file_system_id = aws_efs_file_system.customer_usr_sap_trans.id
  subnet_id      = aws_subnet.customer_production_1a.id
  security_groups = [
    aws_security_group.customer_vpc.id
  ]
}
resource "aws_efs_mount_target" "customer_usr_sap_trans_1b" {
  file_system_id = aws_efs_file_system.customer_usr_sap_trans.id
  subnet_id      = aws_subnet.customer_production_1b.id
  security_groups = [
    aws_security_group.customer_vpc.id
  ]
}
resource "aws_efs_mount_target" "customer_usr_sap_trans_1c" {
  file_system_id = aws_efs_file_system.customer_usr_sap_trans.id
  subnet_id      = aws_subnet.customer_production_1c.id
  security_groups = [
    aws_security_group.customer_vpc.id
  ]
}
##### End customer_usr_sap_trans
