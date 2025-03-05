/*
  Description: Creates VPC endpoints for the Customer
  Comments: None
*/


locals {
  nlb_subnet_list = [for key, value in var.endpoint_nlb_subnets :
    local.layer_00_outputs.infrastructure.subnets[value].id
  ]
}

###### Endpoint Service and Endpoints
module "endpoint_cpids" {
  source               = "../../EXAMPLE_SOURCE/terraform/ibp/modules/aws-endpoint-services"
  nlb_subnet_list      = local.nlb_subnet_list
  nlb_name             = "${local.source_customer}-nlb-cpids"
  build_user           = module.base_layer_context.build_user
  aws_region           = module.base_layer_context.region
  nlb_target_port      = "80"
  nlb_listener_port    = "80"
  nlb_instance_id      = local.layer_02_outputs.instance_cpids.instance_id
  endpoint_edge_vpc_id = aws_vpc.edge_vpc.id
  endpoint_security_group_list = [
    aws_security_group.edge_vpc_all_egress.id,
    aws_security_group.edge_vpc_ingress.id
  ]
  endpoint_subnet_list = [
    aws_subnet.edge_vpc_1a.id,
    aws_subnet.edge_vpc_1b.id
  ]
}

module "endpoint_webdispatcher_44301" {
  source               = "../../EXAMPLE_SOURCE/terraform/ibp/modules/aws-endpoint-services"
  nlb_subnet_list      = local.nlb_subnet_list
  nlb_name             = "${local.source_customer}-nlb-wdisp-44301"
  build_user           = module.base_layer_context.build_user
  aws_region           = module.base_layer_context.region
  nlb_target_port      = "44301"
  nlb_listener_port    = "443"
  nlb_instance_id      = local.layer_02_outputs.instance_webdispatcher.instance_id
  endpoint_edge_vpc_id = aws_vpc.edge_vpc.id
  endpoint_security_group_list = [
    aws_security_group.edge_vpc_all_egress.id,
    aws_security_group.edge_vpc_ingress.id
  ]
  endpoint_subnet_list = [
    aws_subnet.edge_vpc_1a.id,
    aws_subnet.edge_vpc_1b.id
  ]
}

module "endpoint_webdispatcher_44303" {
  source               = "../../EXAMPLE_SOURCE/terraform/ibp/modules/aws-endpoint-services"
  nlb_subnet_list      = local.nlb_subnet_list
  nlb_name             = "${local.source_customer}-nlb-wdisp-44303"
  build_user           = module.base_layer_context.build_user
  aws_region           = module.base_layer_context.region
  nlb_target_port      = "44303"
  nlb_listener_port    = "443"
  nlb_instance_id      = local.layer_02_outputs.instance_webdispatcher.instance_id
  endpoint_edge_vpc_id = aws_vpc.edge_vpc.id
  endpoint_security_group_list = [
    aws_security_group.edge_vpc_all_egress.id,
    aws_security_group.edge_vpc_ingress.id
  ]
  endpoint_subnet_list = [
    aws_subnet.edge_vpc_1a.id,
    aws_subnet.edge_vpc_1b.id
  ]
}

module "endpoint_webdispatcher_44304" {
  source               = "../../EXAMPLE_SOURCE/terraform/ibp/modules/aws-endpoint-services"
  nlb_subnet_list      = local.nlb_subnet_list
  nlb_name             = "${local.source_customer}-nlb-wdisp-44304"
  build_user           = var.build_user
  aws_region           = var.aws_region
  nlb_target_port      = "44304"
  nlb_listener_port    = "443"
  nlb_instance_id      = local.layer_02_outputs.instance_webdispatcher.instance_id
  endpoint_edge_vpc_id = aws_vpc.edge_vpc.id
  endpoint_security_group_list = [
    aws_security_group.edge_vpc_all_egress.id,
    aws_security_group.edge_vpc_ingress.id
  ]
  endpoint_subnet_list = [
    aws_subnet.edge_vpc_1a.id,
    aws_subnet.edge_vpc_1b.id
  ]
}

module "endpoint_webdispatcher_44306" {
  source               = "../../EXAMPLE_SOURCE/terraform/ibp/modules/aws-endpoint-services"
  nlb_subnet_list      = local.nlb_subnet_list
  nlb_name             = "${local.source_customer}-nlb-wdisp-44306"
  build_user           = var.build_user
  aws_region           = var.aws_region
  nlb_target_port      = "44306"
  nlb_listener_port    = "443"
  nlb_instance_id      = local.layer_02_outputs.instance_webdispatcher.instance_id
  endpoint_edge_vpc_id = aws_vpc.edge_vpc.id
  endpoint_security_group_list = [
    aws_security_group.edge_vpc_all_egress.id,
    aws_security_group.edge_vpc_ingress.id
  ]
  endpoint_subnet_list = [
    aws_subnet.edge_vpc_1a.id,
    aws_subnet.edge_vpc_1b.id
  ]
}
