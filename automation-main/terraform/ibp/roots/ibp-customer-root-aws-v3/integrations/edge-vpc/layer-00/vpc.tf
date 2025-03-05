/*
  Description: This Customer Edge VPC is made custom to customer requirements.
    With the reserved cidr range we receive from the customer. We publish our
    application into the reserved range.  The customer can then create a site-2-site
    vpn connection and "own" the network.
  Comments:
    Customer provided values:
      cidr_block: This is a range of 32 ip addresses from the customer network reserved for us.
                  The subnets are simply this range divided in half
      security group ingress cidr_block:  These are the ranges where we can expect to see traffic from the customer

    !!! For DR Customers, ensure both subnets are specified in the NLB build

*/

module "context_aws_vpc_edge" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "vpc"
  description = "${module.base_layer_context.resource_prefix} edge VPC"
}

###### VPC Creation
resource "aws_vpc" "edge_vpc" {
  cidr_block       = var.edge_vpc_cidr
  instance_tenancy = "default"
  tags = merge(module.context_aws_vpc_edge.tags, {
    Name = module.base_layer_context.resource_prefix
  })
  lifecycle {
    prevent_destroy = false
  }
}
