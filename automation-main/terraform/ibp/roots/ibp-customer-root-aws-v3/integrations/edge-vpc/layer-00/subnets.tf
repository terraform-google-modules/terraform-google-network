/*
  Description: Handles VPC subnet creation; Creates basic subnets accross default availabilty zones
  Comments: None
*/

##### Subnet Creation
module "context_aws_subnet_edge_vpc_1a" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "subnet-edge-vpc-1a"
  description = "${module.base_layer_context.resource_prefix} subnet for edge VPC"
}

resource "aws_subnet" "edge_vpc_1a" {
  vpc_id                  = aws_vpc.edge_vpc.id
  availability_zone       = "us-gov-west-1a"
  cidr_block              = var.edge_vpc_1a_cidr
  map_public_ip_on_launch = "false"
  tags                    = module.context_aws_subnet_edge_vpc_1a.tags
  lifecycle {
    prevent_destroy = false
  }
}

module "context_aws_subnet_edge_vpc_1b" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "subnet-edge-vpc-1b"
  description = "${module.base_layer_context.resource_prefix} subnet for edge VPC"
}

resource "aws_subnet" "edge_vpc_1b" {
  vpc_id                  = aws_vpc.edge_vpc.id
  availability_zone       = "us-gov-west-1b"
  cidr_block              = var.edge_vpc_1b_cidr
  map_public_ip_on_launch = "false"
  tags                    = module.context_aws_subnet_edge_vpc_1b.tags
  lifecycle {
    prevent_destroy = false
  }
}
