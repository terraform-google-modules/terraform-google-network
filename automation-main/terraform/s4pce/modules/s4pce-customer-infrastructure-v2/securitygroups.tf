/*
  Description: Security groups for the Customer VPC
  Comments:
    Security Groups:
      * customer_default_sg
      * customer_all_egress
      * customer_vpc
      * customer_access_management
*/

##### Remove all rules from default security Group
resource "aws_default_security_group" "customer_default_sg" {
  vpc_id = aws_vpc.customer.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-default"
    Description = "${module.base_layer_context.environment_values.kv.prefix_friendly_name} Default"
  })
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}


##### All-Egress
module "context_aws_security_group_customer_all_egress" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "all-egress"
  description = "all egress security group"
}
resource "aws_security_group" "customer_all_egress" {
  vpc_id      = aws_vpc.customer.id
  name        = module.context_aws_security_group_customer_all_egress.name
  description = module.context_aws_security_group_customer_all_egress.description
  tags        = module.context_aws_security_group_customer_all_egress.tags
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
# Standard All-Egress Rules
resource "aws_vpc_security_group_egress_rule" "customer_all_egress" {
  security_group_id = aws_security_group.customer_all_egress.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allows all outbound IPv4 traffic for ${module.base_layer_context.tags.VPC} VPC"
}

##### Access-VPC
module "context_aws_security_group_customer_vpc" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "vpc"
  description = "IntraVPC Rules"
}
resource "aws_security_group" "customer_vpc" {
  vpc_id      = aws_vpc.customer.id
  name        = module.context_aws_security_group_customer_vpc.name
  description = module.context_aws_security_group_customer_vpc.description
  tags        = module.context_aws_security_group_customer_vpc.tags
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
# Standard Access-VPC Rules
resource "aws_vpc_security_group_ingress_rule" "vpc_self_ingress_ipv4" {
  security_group_id = aws_security_group.customer_vpc.id
  ip_protocol       = "-1"
  cidr_ipv4         = var.network.primary.cidr
  description       = "Allows all ingress ipv4 traffic"
}
resource "aws_vpc_security_group_egress_rule" "vpc_self_egress_ipv4" {
  security_group_id = aws_security_group.customer_vpc.id
  ip_protocol       = "-1"
  cidr_ipv4         = var.network.primary.cidr
  description       = "Allows all egress ipv4 traffic"
}
##### End Access-VPC


##### Access-Management
module "context_aws_security_group_customer_access_management" {
  source      = "../../../shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "management"
  description = "Management VPC Rules"
}
resource "aws_security_group" "customer_access_management" {
  vpc_id      = aws_vpc.customer.id
  name        = module.context_aws_security_group_customer_access_management.name
  description = module.context_aws_security_group_customer_access_management.description
  tags        = module.context_aws_security_group_customer_access_management.tags
  lifecycle {
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}
##### End Access-Management
