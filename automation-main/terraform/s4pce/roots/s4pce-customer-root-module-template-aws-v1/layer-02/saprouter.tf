/*
  Description: SAP Router Resources
  Layer: 02
  Dependencies:
    layer-00: outputs
    layer-01: outputs
*/

locals {
  # Parse the instance list and creates a new list of instances that have `endpoint_port_list` defined
  instance_list_saprouter = { for key, value in var.instance_list : key => value if contains(["router"], value.productname) }
  deploy_saprouter        = length(local.instance_list_saprouter) > 0 ? 1 : 0
}


##### Security Group
module "context_aws_security_group_saprouter" {
  count       = local.deploy_saprouter
  source      = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context"
  context     = module.base_layer_context.context
  name        = "saprouter"
  description = "SAP Router Rules"
}
resource "aws_security_group" "saprouter" {
  count       = local.deploy_saprouter
  vpc_id      = local.layer_00_outputs.infrastructure.vpc_customer.id
  name        = module.context_aws_security_group_saprouter[0].name
  description = module.context_aws_security_group_saprouter[0].description
  tags        = module.context_aws_security_group_saprouter[0].tags
}
# Standard Access-VPC Rules
resource "aws_security_group_rule" "saprouter_standard_ingress" {
  count             = local.deploy_saprouter
  security_group_id = aws_security_group.saprouter[0].id
  type              = "ingress"
  protocol          = "all"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = var.saprouter_ingress_cidr
  description       = "Allows ingress traffic for SAP Router"
}
##### End Security Group


module "instance_saprouter" {
  for_each = local.instance_list_saprouter

  source = "EXAMPLE_SOURCE/terraform/shared/modules/aws-instance"
  # Use default values unless specified otherwise
  search_ami_name            = var.image_application_name
  search_ami_owner_id        = var.ami_owner_default
  instance_type              = lower(each.value.instance_type)
  ec2_key                    = aws_key_pair.main01.key_name
  monitoring                 = true
  root_encrypted             = true
  root_delete_on_termination = false
  enable_state_recovery      = true
  security_group_ids = concat(lookup(each.value, "securitygroups", []), [
    local.layer_00_outputs.infrastructure.security_group_vpc.id,
    local.layer_00_outputs.infrastructure.security_group_all_egress.id,
    local.layer_00_outputs.infrastructure.security_group_customer_access_management.id,
    aws_security_group.saprouter[0].id,
  ])
  subnet_id                            = local.layer_00_outputs.infrastructure.subnet_edge_1a.id
  iam_instance_profile                 = local.layer_01_outputs.iam_role_customer_default.id
  aws_region                           = module.context_instance_list[each.key].region
  context                              = module.context_instance_list[each.key].context
  associate_elastic_ip_address         = true
  route53_associate_private_ip_address = true
  route53_zoneid                       = local.layer_00_outputs.infrastructure.route53_zone.id
  route53_associate_cname              = false
  route53_additional_cnames            = concat(lookup(each.value, "cnames", []), [])
}
##### End Instance
