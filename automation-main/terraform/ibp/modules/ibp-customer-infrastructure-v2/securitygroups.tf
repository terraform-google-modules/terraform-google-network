/*
  Description: Security groups for the Customer VPC
  Comments: N/A
*/

##### Remove all rules from default security Group
resource "aws_default_security_group" "customer_default_sg" {
  vpc_id = aws_vpc.customer.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-default"
    Description = title("${module.base_layer_context.environment_values.kv.prefix_friendly_name} Default")
  })
}

###### Security Groups
### All-Egress
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
}
# Standard All-Egress Rules
resource "aws_security_group_rule" "customer_all_egress" {
  security_group_id = aws_security_group.customer_all_egress.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allows all outbound traffic for ${module.base_layer_context.tags.VPC} VPC"
}
### End All-Egress


### Access-VPC
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
}
resource "aws_security_group_rule" "customer_vpc_standard_ingress" {
  security_group_id = aws_security_group.customer_vpc.id
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = [aws_vpc.customer.cidr_block]
  description       = "Allows ingress traffic from ${module.base_layer_context.tags.VPC} VPC to all protocols and ports"
}
resource "aws_security_group_rule" "customer_vpc_standard_egress" {
  security_group_id = aws_security_group.customer_vpc.id
  type              = "egress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = [aws_vpc.customer.cidr_block]
  description       = "Allows egress traffic to ${module.base_layer_context.tags.VPC} to all protocols and ports"
}

### Access-Management
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
}
# Access-Management Rules
resource "aws_security_group_rule" "customer_access_management_ingress" {
  security_group_id = aws_security_group.customer_access_management.id
  type              = "ingress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = [data.aws_vpc.management.cidr_block]
  description       = "Allows traffic from ${data.aws_vpc.management.tags.Name} ingress to all protocols and ports"
}
resource "aws_security_group_rule" "customer_access_management_egress" {
  security_group_id = aws_security_group.customer_access_management.id
  type              = "egress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = [data.aws_vpc.management.cidr_block]
  description       = "Allows traffic to ${data.aws_vpc.management.tags.Name} egress to all protocols and ports"
}
##### End Access-Management
