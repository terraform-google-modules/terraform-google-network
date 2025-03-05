/*
  Description: Security Groups for instances and loadbalancer
  Comments:
*/

# Security Group for QTM Instances
resource "aws_security_group" "qtm_instance" {
  vpc_id      = var.vpc_info.id
  name        = "${random_id.module.hex}-instance"
  description = "qtm"
  tags        = merge(local.default_tags, { Description = "QTM Instance Security Group" })
}
resource "aws_vpc_security_group_egress_rule" "qtm_instance_egress" {
  for_each          = var.egress_cidrs
  security_group_id = aws_security_group.qtm_instance.id
  cidr_ipv4         = each.value
  ip_protocol       = "-1" # NEEDS TO BE DEFINED FROM SAP
  # from_port = # NEEDS TO BE DEFINED FROM SAP
  # to_port   = # NEEDS TO BE DEFINED FROM SAP
  description = "Allows QTM to EGRESS to ${each.key}"
  tags        = merge(local.default_tags, {})
}
resource "aws_vpc_security_group_ingress_rule" "qtm_instance_ingress_intravpc" {
  security_group_id = aws_security_group.qtm_instance.id
  cidr_ipv4         = var.vpc_info.cidr_block
  ip_protocol       = "-1" # NEEDS TO BE DEFINED FROM SAP
  # from_port = # NEEDS TO BE DEFINED FROM SAP
  # to_port   = # NEEDS TO BE DEFINED FROM SAP
  description = "Allows IntraVPC INGRESS to QTM"
  tags        = merge(local.default_tags, {})
}

# Security Group for QTM Application LoadBalancer
resource "aws_security_group" "qtm_lb" {
  vpc_id      = var.vpc_info.id
  name        = "${random_id.module.hex}-alb"
  description = "qtm"
  tags        = merge(local.default_tags, { Description = "QTM ALB Security Group" })
}
# Standard Egress Rules
resource "aws_vpc_security_group_ingress_rule" "qtm_lb_ingress" {
  for_each          = var.adv_alb_ingress_cidrs
  security_group_id = aws_security_group.qtm_lb.id
  cidr_ipv4         = each.value
  ip_protocol       = "-1" # NEEDS TO BE DEFINED FROM SAP
  # from_port = # NEEDS TO BE DEFINED FROM SAP
  # to_port   = # NEEDS TO BE DEFINED FROM SAP
  description = "Allows INGRESS to qtm_lb from ${each.key}"
  tags        = merge(local.default_tags, {})
}
resource "aws_vpc_security_group_egress_rule" "qtm_lb_egress" {
  security_group_id = aws_security_group.qtm_lb.id
  cidr_ipv4         = "${module.instance_list["qtm_webdispatcher"].private_ip}/32"
  ip_protocol       = "TCP"   # NEEDS TO BE DEFINED FROM SAP
  from_port         = "44301" # NEEDS TO BE DEFINED FROM SAP
  to_port           = "44301" # NEEDS TO BE DEFINED FROM SAP
  description       = "Allows qtm_lb to EGRESS to ..."
  tags              = merge(local.default_tags, {})
}



output "security_groups" {
  description = "AWS QTM Module Security Groups"
  value = {
    qtm_lb = {
      id   = aws_security_group.qtm_lb.id
      name = aws_security_group.qtm_lb.name
    }
    qtm_instance = {
      id   = aws_security_group.qtm_instance.id
      name = aws_security_group.qtm_instance.name
  } }
}
