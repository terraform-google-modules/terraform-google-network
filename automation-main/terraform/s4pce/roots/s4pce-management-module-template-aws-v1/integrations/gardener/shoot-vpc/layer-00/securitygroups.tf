/*
  Description: VPC Security Groups
  Comments:
    * shoot_default: Default Security Group, Intentionally left empty
    * shoot_all_egress: Allows all egress traffic for the VPC
    * shoot_vpc: IntraVPC Rules
    * shoot_access_management: Management VPC Rules
*/

### Remove all rules from default security Group
resource "aws_default_security_group" "shoot_default" {
  vpc_id = aws_vpc.shoot.id
  tags = {
    Name        = "${local.layer_resource_prefix}-default"
    Description = "default security group"
  }
}

resource "aws_security_group" "shoot_all_egress" {
  vpc_id      = aws_vpc.shoot.id
  name        = "${local.layer_resource_prefix}-all-egress"
  description = "all egress security group"
  tags = {
    Name        = "${local.layer_resource_prefix}-all-egress"
    Description = "all egress security group"
  }
}
### Standard All-Egress Rules
resource "aws_security_group_rule" "shoot_all_egress" {
  security_group_id = aws_security_group.shoot_all_egress.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allows all outbound traffic"
}

resource "aws_security_group" "shoot_vpc" {
  vpc_id      = aws_vpc.shoot.id
  name        = "${local.layer_resource_prefix}-vpc"
  description = "IntraVPC Rules"
  tags = {
    Name        = "${local.layer_resource_prefix}-vpc"
    Description = "IntraVPC Rules"
  }
}

### Standard Access-VPC Rules
resource "aws_security_group_rule" "shoot_vpc_standard_ingress" {
  security_group_id = aws_security_group.shoot_vpc.id
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Standard Ingress Rules"
}
resource "aws_security_group_rule" "shoot_vpc_standard_egress" {
  security_group_id = aws_security_group.shoot_vpc.id
  type              = "egress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Standard Egress Rules"
}
##### End Access-VPC

##### Access-Management
resource "aws_security_group" "shoot_access_management" {
  vpc_id      = aws_vpc.shoot.id
  name        = "${local.layer_resource_prefix}-management"
  description = "Management VPC Rules"
  tags = {
    Name        = "${local.layer_resource_prefix}-management"
    Description = "Management VPC Rules"
  }
}
resource "aws_security_group_rule" "shoot_access_management_ingress" {
  security_group_id = aws_security_group.shoot_access_management.id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = [local.layer_00_outputs.vpc_main01.cidr_block]
  description       = "Allows all inbound traffic - ${local.layer_00_outputs.vpc_main01.name}"
}
resource "aws_security_group_rule" "shoot_access_management_egress" {
  security_group_id = aws_security_group.shoot_access_management.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = [local.layer_00_outputs.vpc_main01.cidr_block]
  description       = "Allows all outbound traffic - ${local.layer_00_outputs.vpc_main01.name}"
}
##### End Access-Management

##### Outputs
output "security_group_shoot_vpc" { value = {
  id   = aws_security_group.shoot_vpc.id
  name = aws_security_group.shoot_vpc.tags.Name
} }
output "security_group_shoot_all_egress" { value = {
  id   = aws_security_group.shoot_all_egress.id
  name = aws_security_group.shoot_all_egress.tags.Name
} }
output "security_group_shoot_access_management" { value = {
  id   = aws_security_group.shoot_access_management.id
  name = aws_security_group.shoot_access_management.tags.Name
} }
