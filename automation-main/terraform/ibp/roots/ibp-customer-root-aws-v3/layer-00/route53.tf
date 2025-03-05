/*
  Description: Route53 zone association and record creation
  Comments: N/A
*/

##### Associate the customer VPC with the Route 53 Management Hosted Zone
resource "aws_route53_zone_association" "customer" {
  zone_id = local.management_layer_00_outputs.route53_zone_main01.id
  vpc_id  = module.ibp_customer_infrastructure.vpc_customer_id
}
