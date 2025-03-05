/*
  Description: Handles VPC security group creation
  Layer: 00
  Dependencies:
    layer-00: vpc
  Comments:
    Security Groups:
      main01_default
      main01_all_egress
      main01_ingress
*/


##### Ingress
module "context_aws_security_group_main01_vpn_ingress" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "vpn-ingress"
  description = "${module.base_layer_context.custom_values.kv.prefix_friendly_name} vpn ingress"
}
resource "aws_security_group" "main01_vpn_ingress" {
  vpc_id      = local.edge_vpc_layer_00_outputs.vpc_main01.id
  name        = module.context_aws_security_group_main01_vpn_ingress.name
  description = module.context_aws_security_group_main01_vpn_ingress.description
  tags        = module.context_aws_security_group_main01_vpn_ingress.tags
}
# Standard Ingress Rules
resource "aws_security_group_rule" "main01_vpn_ingress_standard_ingress" {
  security_group_id = aws_security_group.main01_vpn_ingress.id
  type              = "ingress"
  protocol          = "udp"
  from_port         = 1194
  to_port           = 1194
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Public ingress to OpenVPN"
}
resource "aws_security_group_rule" "main01_vpn_ingress_intra_vpc" {
  security_group_id = aws_security_group.main01_vpn_ingress.id
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = [local.edge_vpc_layer_00_outputs.vpc_main01.cidr_block]
  description       = "Allow intra VPC communication"
}
resource "aws_security_group_rule" "main01_vpn_ingress_ssh" {
  security_group_id = aws_security_group.main01_vpn_ingress.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  # Used in initial setup
  self = true
  // cidr_blocks       = []
  description = "Setup Rule"
}
##### End Ingress
