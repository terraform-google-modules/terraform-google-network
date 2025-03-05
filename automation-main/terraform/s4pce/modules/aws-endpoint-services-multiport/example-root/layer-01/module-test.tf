/*
  Description: Test the module
  Comments: N/A
*/

##### Documentation of module inputs
// module "endpoint_test_80" {
//   source = "../"
//   context                      = (required) null context input
//   nlb_subnet_list              = (required) (List) Subnets where the network loadbalancers are created. This should be in the source VPC
//   nlb_name                     = (required) (String) Name of the network loadbalancer
//   principal_arns               = (optional) (List)   Allows a principal to discover a VPC endpoint service
//   nlb_port_list                = (required) (List) Ports that will be mapped between the endpoint and instance
//   nlb_target_id                = (required) (String) NLB will redirect to this instance
//   nlb_target_ip                = (optional) (boolean) Default False. True to target IP Address. False to target Instance ID
//   nlb_target_az_all            = (optional) (boolean) Default False. True to set target AZ to all.  This is required if the ip address is outside the VPC.
//   endpoint_edge_vpc_id         = (required) (String) Target VPC to create the endpoint in. This should be the consuming VPC
//   endpoint_security_group_list = (required) (List) Security Groups applied to the endpoint.  This is in the consuming VPC
//   endpoint_subnet_list         = (required) (List) Each subnet that should have an endpoint. This is in the consuming VPC
// }


module "endpoint_test_instance" {
  source               = "../../"
  context              = local.layer00.base_context
  nlb_subnet_list      = [local.layer00.service_network.subnets["192.168.1.0/24"].id]
  nlb_name             = "${local.layer00.base_context.customer}-instance"
  nlb_port_list        = ["80", "443"]
  nlb_target_id        = local.layer00.test_instance
  endpoint_edge_vpc_id = local.layer00.consumer_network.vpc.id
  endpoint_security_group_list = [
    local.layer00.consumer_network.security_groups["base_egress"].id,
    local.layer00.consumer_network.security_groups["base_ingress"].id,
  ]
  endpoint_subnet_list = [local.layer00.consumer_network.subnets["192.168.2.0/24"].id]
}

module "endpoint_test_ip" {
  source            = "../../"
  context           = local.layer00.base_context
  nlb_subnet_list   = [local.layer00.service_network.subnets["192.168.1.0/24"].id]
  nlb_name          = "${local.layer00.base_context.customer}-ip"
  nlb_port_list     = ["8080", "8443"]
  nlb_target_id     = "172.16.10.50"
  nlb_target_ip     = true
  nlb_target_az_all = true
  principal_arns = [
    "arn:${local.layer00.base_context.partition}:iam::${local.layer00.base_context.account_id}:root",
  ]
  endpoint_edge_vpc_id = local.layer00.consumer_network.vpc.id
  endpoint_security_group_list = [
    local.layer00.consumer_network.security_groups["base_egress"].id,
    local.layer00.consumer_network.security_groups["base_ingress"].id,
  ]
  endpoint_subnet_list = [local.layer00.consumer_network.subnets["192.168.2.0/24"].id]
}
