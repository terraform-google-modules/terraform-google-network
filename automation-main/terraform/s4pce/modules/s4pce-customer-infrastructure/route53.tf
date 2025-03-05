/*
  Description: Route53 zone association and record creation
*/

##### Associate the customer VPC with the Route 53 Management Hosted Zone
resource "aws_route53_zone_association" "customer" {
  count   = var.custom_no_local_dns_zone == false ? 1 : 0
  zone_id = var.route53_zone_management_id
  vpc_id  = aws_vpc.customer.id
}
