/*
  Description: VPC Security Groups
  Comments:
    * main01_default: Default Security Group, Intentionally left empty
    * main01_all_egress: Allows all egress traffic for the VPC
    * main01_vpc: IntraVPC Rules
    * main01_relay: SES Relay Rules
    * main01_access_edge: Edge ingress rules
    * main01_access_edge_ssh: Edge ingress rules for SSH specifically
    * main01_access_edge_nessus: Edge ingress rules for Tenable Nessus
    * main01_efs_common: Allows traffic for the common EFS shares
*/


##### Remove all rules from default security Group
resource "aws_default_security_group" "main01_default" {
  vpc_id = aws_vpc.main01.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-default"
    Description = "default security group"
  })
}

####### Security Groups
##### All-Egress
module "context_aws_security_group_main01_all_egress" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "all-egress"
  description = "all egress security group"
}
resource "aws_security_group" "main01_all_egress" {
  vpc_id      = aws_vpc.main01.id
  name        = module.context_aws_security_group_main01_all_egress.name
  description = module.context_aws_security_group_main01_all_egress.description
  tags        = module.context_aws_security_group_main01_all_egress.tags
}
# Standard All-Egress Rules
resource "aws_security_group_rule" "main01_all_egress" {
  security_group_id = aws_security_group.main01_all_egress.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allows all outbound traffic for ${module.base_layer_context.tags.VPC} VPC"
}
##### End All-Egress

##### Access-VPC
module "context_aws_security_group_main01_vpc" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "vpc"
  description = "IntraVPC Rules"
}
resource "aws_security_group" "main01_vpc" {
  vpc_id      = aws_vpc.main01.id
  name        = module.context_aws_security_group_main01_vpc.name
  description = module.context_aws_security_group_main01_vpc.description
  tags        = module.context_aws_security_group_main01_vpc.tags
}
# Standard Access-VPC Rules
resource "aws_security_group_rule" "main01_vpc_standard_ingress" {
  security_group_id = aws_security_group.main01_vpc.id
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allows ingress traffic from ${module.base_layer_context.tags.VPC} VPC to all protocols and ports"
}
resource "aws_security_group_rule" "main01_vpc_standard_egress" {
  security_group_id = aws_security_group.main01_vpc.id
  type              = "egress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = [var.vpc_cidr_block]
  description       = "Allows egress traffic to ${module.base_layer_context.tags.VPC} to all protocols and ports"
}
##### End Access-VPC


##### Access-Relay
module "context_aws_security_group_main01_relay" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "relay"
  description = "SES Relay Rules"
}
resource "aws_security_group" "main01_relay" {
  vpc_id      = aws_vpc.main01.id
  name        = module.context_aws_security_group_main01_relay.name
  description = module.context_aws_security_group_main01_relay.description
  tags        = module.context_aws_security_group_main01_relay.tags
}
# Standard Access-Relay Rules
resource "aws_security_group_rule" "main01_relay_standard_ingress" {
  security_group_id = aws_security_group.main01_relay.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 25
  to_port           = 25
  cidr_blocks       = flatten([var.vpc_cidr_block, var.tenant_vpc_cidr_block])
  description       = "Allows ingress traffic for SES Mail Relay"
}
##### End Access-Relay


##### Access-External
module "context_aws_security_group_main01_access_edge" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "edge"
  description = "Edge ingress rules"
}
resource "aws_security_group" "main01_access_edge" {
  vpc_id      = aws_vpc.main01.id
  name        = module.context_aws_security_group_main01_access_edge.name
  description = module.context_aws_security_group_main01_access_edge.description
  tags        = module.context_aws_security_group_main01_access_edge.tags
}
# Standard Access-External Rules
resource "aws_security_group_rule" "main01_access_edge_openvpn" {
  security_group_id = aws_security_group.main01_access_edge.id
  type              = "ingress"
  protocol          = "udp"
  from_port         = 1194
  to_port           = 1194
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Public ingress to OpenVPN"
}
resource "aws_security_group_rule" "main01_access_edge_dns_tcp" {
  security_group_id = aws_security_group.main01_access_edge.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 53
  to_port           = 53
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Public ingress for TCP Route 53 DNS"
}
resource "aws_security_group_rule" "main01_access_edge_dns_udp" {
  security_group_id = aws_security_group.main01_access_edge.id
  type              = "ingress"
  protocol          = "udp"
  from_port         = 53
  to_port           = 53
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Public ingress for UDP Route 53 DNS"
}
# Whitelisted Access-External Rules
resource "aws_security_group_rule" "main01_access_edge_whitelist_http" {
  for_each          = var.whitelisted_ip_addresses
  security_group_id = aws_security_group.main01_access_edge.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = [each.key]
  description       = "Public Ingress for HTTP - ${each.value}"
}
resource "aws_security_group_rule" "main01_access_edge_whitelist_https" {
  for_each          = var.whitelisted_ip_addresses
  security_group_id = aws_security_group.main01_access_edge.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = [each.key]
  description       = "Public Ingress for HTTPS - ${each.value}"
}
##### End Access-External

##### Access-External SSH only
module "context_aws_security_group_main01_access_edge_ssh" {
  source = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"

  context     = module.base_layer_context.context
  name        = "edge-ssh"
  description = "Edge ingress rules for SSH specifically"
}
resource "aws_security_group" "main01_access_edge_ssh" {
  vpc_id      = aws_vpc.main01.id
  name        = module.context_aws_security_group_main01_access_edge_ssh.name
  description = module.context_aws_security_group_main01_access_edge_ssh.description
  tags        = module.context_aws_security_group_main01_access_edge_ssh.tags
}
# Whitelisted Access-External SSH only Rules
resource "aws_security_group_rule" "main01_access_edge_whitelist_ssh" {
  for_each          = var.whitelisted_ip_addresses
  security_group_id = aws_security_group.main01_access_edge_ssh.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = [each.key]
  description       = "Public Ingress for SSH - ${each.value}"
}
##### End Access-External SSH only

##### Access-External Nessus
module "context_aws_security_group_main01_access_edge_nessus" {
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "edge-nessus"
  description = "Edge ingress rules for Tenable Nessus"
}
resource "aws_security_group" "main01_access_edge_nessus" {
  vpc_id      = aws_vpc.main01.id
  name        = module.context_aws_security_group_main01_access_edge_nessus.name
  description = module.context_aws_security_group_main01_access_edge_nessus.description
  tags        = module.context_aws_security_group_main01_access_edge_nessus.tags
}
# Whitelisted Access-External Nessus Rules
#   will eventually have to whitelist scp canary and sac canary nat gateway ip addresses
resource "aws_security_group_rule" "main01_access_edge_whitelist_nessus_8834" {
  for_each          = var.whitelisted_ip_addresses
  security_group_id = aws_security_group.main01_access_edge_nessus.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 8834
  to_port           = 8834
  cidr_blocks       = [each.key]
  description       = "Public Ingress for TCP port 8834 - ${each.value}"
}
##### End Access-External Nessus

##### Access-EFS-Common
module "context_aws_security_group_main01_efs_common" {
  source = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"

  context     = module.base_layer_context.context
  name        = "efs-common"
  description = "Allows traffic for the common EFS shares"
}
resource "aws_security_group" "main01_efs_common" {
  vpc_id      = aws_vpc.main01.id
  name        = module.context_aws_security_group_main01_efs_common.name
  description = module.context_aws_security_group_main01_efs_common.description

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = flatten([var.vpc_cidr_block, var.tenant_vpc_cidr_block])
    description = "Allows traffic for the common EFS shares"
  }

  tags = module.context_aws_security_group_main01_efs_common.tags
}
##### End Access-EFS-Common
