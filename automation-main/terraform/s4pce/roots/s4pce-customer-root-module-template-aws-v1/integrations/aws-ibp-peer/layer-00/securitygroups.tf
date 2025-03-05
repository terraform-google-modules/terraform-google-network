/*
  Description: Security groups for the Customer VPC
  Comments: N/A
*/

##### Security Groups
resource "aws_security_group_rule" "s4_customer_access_management_ingress" {
  security_group_id = local.layer_00.infrastructure.security_group_customer_access_management.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.ibp_customer.layer_00.infrastructure.vpc_customer_cidr_block]
  description       = "Allows all ingress traffic - ${local.ibp_customer.layer_00.infrastructure.vpc_customer_name}"
}
resource "aws_security_group_rule" "s4_customer_access_management_egress" {
  security_group_id = local.layer_00.infrastructure.security_group_customer_access_management.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.ibp_customer.layer_00.infrastructure.vpc_customer_cidr_block]
  description       = "Allows all egress traffic - ${local.ibp_customer.layer_00.infrastructure.vpc_customer_name}"
}

resource "aws_security_group_rule" "ibp_customer_access_management_ingress" {
  provider          = aws.ibp
  security_group_id = local.ibp_customer.layer_00.infrastructure.security_group_access_management_id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.layer_00.infrastructure.vpc_customer.cidr_block]
  description       = "Allows all ingress traffic - ${local.layer_00.infrastructure.vpc_customer.name}"
}
resource "aws_security_group_rule" "ibp_customer_access_management_egress" {
  provider          = aws.ibp
  security_group_id = local.ibp_customer.layer_00.infrastructure.security_group_access_management_id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [local.layer_00.infrastructure.vpc_customer.cidr_block]
  description       = "Allows all egress traffic - ${local.layer_00.infrastructure.vpc_customer.name}"
}
