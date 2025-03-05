/*
  Description: Test the module
  Comments: N/A
*/

##### Documentation of module inputs
// module "endpoint_test_80" {
//   source = "../../../modules/aws-endpoint-services"
//   nlb_subnet_list              = (required) (List) Subnets where the network loadbalancers are created. This should be in the source VPC
//   nlb_name                     = (required) (String) Name of the network loadbalancer
//   build_user                   = (required) (String) Employee ID of user running terraform
//   aws_region                   = (required) (String) AWS Region
//   principal_arns               = (optional) (List)   Allows a principal to discover a VPC endpoint service
//   nlb_target_port              = (required) (String) NLB will redirect to this instance port
//   nlb_listener_port            = (required) (String) NLB will listen on this TCP port
//   nlb_instance_id              = (required) (String) NLB will redirect to this instance
//   nlb_target_ip                = (optional) (boolean) Default False. True to target IP Address. False to target Instance ID
//   nlb_target_az_all            = (optional) (boolean) Default False. True to set target AZ to all.  This is required if the ip address is outside the VPC.
//   endpoint_edge_vpc_id         = (required) (String) Target VPC to create the endpoint in. This should be the consuming VPC
//   endpoint_security_group_list = (required) (List) Security Groups applied to the endpoint.  This is in the consuming VPC
//   endpoint_subnet_list         = (required) (List) Each subnet that should have an endpoint. This is in the consuming VPC
// }

##### Example privatelink endpoint with no principal arns
module "endpoint_test_80" {
  source = "../../../modules/aws-endpoint-services"
  nlb_subnet_list = [
    aws_subnet.test_service_vpc.id,
  ]
  nlb_name             = "test-service-vpc-nlb-test-80"
  build_user           = var.build_user
  aws_region           = var.aws_region
  nlb_target_port      = "80"
  nlb_listener_port    = "80"
  nlb_instance_id      = aws_instance.instance.id
  endpoint_edge_vpc_id = aws_vpc.test_consumer_vpc.id
  endpoint_security_group_list = [
    aws_default_security_group.test_consumer_vpc.id,
  ]
  endpoint_subnet_list = [
    aws_subnet.test_consumer_vpc.id,
  ]
}

##### Example privatelink endpoint with principal arns
module "endpoint_test_443" {
  source = "../../../modules/aws-endpoint-services"
  nlb_subnet_list = [
    aws_subnet.test_service_vpc.id,
  ]
  nlb_name   = "test-service-vpc-nlb-test-443"
  build_user = var.build_user
  aws_region = var.aws_region
  principal_arns = [
    "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root",
  ]
  nlb_target_port      = "443"
  nlb_listener_port    = "443"
  nlb_instance_id      = aws_instance.instance.id
  endpoint_edge_vpc_id = aws_vpc.test_consumer_vpc.id
  endpoint_security_group_list = [
    aws_default_security_group.test_consumer_vpc.id,
  ]
  endpoint_subnet_list = [
    aws_subnet.test_consumer_vpc.id,
  ]
}
