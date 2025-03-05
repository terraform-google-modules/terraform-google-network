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


##### Remove all rules from default security Group
resource "aws_default_security_group" "main01_default" {
  vpc_id = aws_vpc.main01.id
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-default"
    Description = "${module.base_layer_context.custom_values.kv.prefix_friendly_name} Default Security Group"
  })
}

####### Security Groups
##### All-Egress
module "context_aws_security_group_main01_all_egress" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "all-egress"
  description = "${module.base_layer_context.custom_values.kv.prefix_friendly_name} all egress"
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
  description       = "Allows all outbound traffic for ${module.base_layer_context.custom_values.kv.prefix_friendly_name}"
}
##### End All-Egress

##### Ingress
module "context_aws_security_group_main01_ingress" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "ingress"
  description = "${module.base_layer_context.custom_values.kv.prefix_friendly_name} ingress"
}
resource "aws_security_group" "main01_ingress" {
  vpc_id      = aws_vpc.main01.id
  name        = module.context_aws_security_group_main01_ingress.name
  description = module.context_aws_security_group_main01_ingress.description
  tags        = module.context_aws_security_group_main01_ingress.tags
}
# Standard Ingress Rules
resource "aws_security_group_rule" "main01_ingress_standard_ingress" {
  security_group_id = aws_security_group.main01_ingress.id
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = concat(var.vpc_ingress_cidr_list, [aws_vpc.main01.cidr_block])
  description       = "Allows ingress to ${module.base_layer_context.custom_values.kv.prefix_friendly_name}"
}
##### End Ingress
