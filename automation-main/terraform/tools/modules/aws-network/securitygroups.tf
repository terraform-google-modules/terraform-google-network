/*
  Description: Sanitize default security group. Create one ingress and one egress security group.
  Comments:
*/

##### Remove all rules from default security Group
resource "aws_default_security_group" "main_default_sg" {
  vpc_id = aws_vpc.main.id
  tags   = merge(local.tags_vpc, {})
}


##### Base-Egress
resource "random_id" "main_base_egress" {
  byte_length = 8
}
resource "aws_security_group" "main_base_egress" {
  vpc_id      = aws_vpc.main.id
  name        = random_id.main_base_egress.hex
  description = "base-egress ${aws_vpc.main.id}"
  tags        = merge(local.tags_vpc, {})
}
# Standard Base-Egress Rules
resource "aws_vpc_security_group_egress_rule" "main_base_egress_ipv4" {
  count             = var.use_default_security_rules ? 1 : 0
  security_group_id = aws_security_group.main_base_egress.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
  description       = "Allows all egress ipv4 traffic"
}
resource "aws_vpc_security_group_egress_rule" "main_base_egress_ipv6" {
  count             = var.use_default_security_rules ? 1 : 0
  security_group_id = aws_security_group.main_base_egress.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
  description       = "Allows all egress ipv6 traffic"
}
### End Base-Egress


##### Base-Ingress
resource "random_id" "main_base_ingress" {
  byte_length = 8
}
resource "aws_security_group" "main_base_ingress" {
  vpc_id      = aws_vpc.main.id
  name        = random_id.main_base_ingress.hex
  description = "base-ingress ${aws_vpc.main.id}"
  tags        = merge(local.tags_vpc, {})
}
# Standard Access-VPC Rules
locals {
  security_groups_ipv4_cidr_blocks = concat([aws_vpc.main.cidr_block], local.cidr_block_additional)
  security_groups_ipv6_cidr_blocks = merge({ "main_vpc" = aws_vpc.main.ipv6_cidr_block })
}
resource "aws_vpc_security_group_ingress_rule" "vpc_self_ingress_ipv4" {
  for_each          = var.use_default_security_rules ? toset(local.security_groups_ipv4_cidr_blocks) : []
  security_group_id = aws_security_group.main_base_ingress.id
  ip_protocol       = "-1"
  cidr_ipv4         = each.value
  description       = "Allows all ingress ipv4 traffic"
}
resource "aws_vpc_security_group_ingress_rule" "vpc_self_ingress_ipv6" {
  for_each          = (var.use_default_security_rules && local.enable_ipv6) ? local.security_groups_ipv6_cidr_blocks : {}
  security_group_id = aws_security_group.main_base_ingress.id
  ip_protocol       = "-1"
  cidr_ipv6         = each.value
  description       = "Allows all ingress ipv6 traffic"
}
##### End Base-Ingress

output "security_groups" {
  description = "Security Groups"
  value = {
    base_ingress = {
      id   = aws_security_group.main_base_ingress.id
      name = aws_security_group.main_base_ingress.name
    }
    base_egress = {
      id   = aws_security_group.main_base_egress.id
      name = aws_security_group.main_base_egress.name
  } }
}
