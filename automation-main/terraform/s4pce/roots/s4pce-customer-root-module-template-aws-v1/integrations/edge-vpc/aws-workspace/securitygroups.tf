/*
  Description: Security groups for the Customer VPC
  Comments: N/A
*/


###### Security Groups
### Access-Management Rules
resource "aws_security_group_rule" "customer_access_management_ingress" {
  security_group_id = local.edge_vpc_layer_00_outputs.security_group_main01_ingress.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.management_layer_00_outputs.vpc_main01.cidr_block]
  description       = "Allows all inbound traffic - ${local.management_layer_00_outputs.vpc_main01.name}"
}
resource "aws_security_group_rule" "customer_access_management_egress" {
  security_group_id = local.edge_vpc_layer_00_outputs.security_group_main01_all_egress.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.management_layer_00_outputs.vpc_main01.cidr_block]
  description       = "Allows all outbound traffic - ${local.management_layer_00_outputs.vpc_main01.name}"
}
