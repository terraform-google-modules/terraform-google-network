/*
  Description: Handles VPC security group creation
  Comments: N/A
*/

###### Security Groups
##### Remove all rules from default security Group
module "context_aws_default_security_group_edge_vpc" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "default"
  description = "${module.base_layer_context.resource_prefix} edge VPC default"
}

resource "aws_default_security_group" "edge_vpc" {
  vpc_id = aws_vpc.edge_vpc.id
  tags   = module.context_aws_default_security_group_edge_vpc.tags
  lifecycle {
    prevent_destroy = false
  }
}

### All-Egress
module "context_aws_security_group_all_egress" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "all-egress"
  description = "${module.base_layer_context.resource_prefix} edge VPC all egress"
}

resource "aws_security_group" "edge_vpc_all_egress" {
  vpc_id      = aws_vpc.edge_vpc.id
  name        = module.context_aws_security_group_all_egress.name
  description = module.context_aws_security_group_all_egress.description

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allows all outbound traffic for ${module.base_layer_context.resource_prefix}-edge VPC subnet"
  }

  tags = module.context_aws_security_group_all_egress.tags
  lifecycle {
    prevent_destroy = false
  }
}

### Ingress
module "context_aws_security_group_ingress" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "ingress"
  description = "${module.base_layer_context.resource_prefix} edge VPC ingress"
}

resource "aws_security_group" "edge_vpc_ingress" {
  vpc_id      = aws_vpc.edge_vpc.id
  name        = module.context_aws_security_group_ingress.name
  description = module.context_aws_security_group_ingress.description

  ingress {
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks = var.edge_vpc_ingress_cidr_list
    description = "Allows ingress on TCP/443 to ${module.base_layer_context.resource_prefix}-edge VPC subnet"
  }

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = [aws_vpc.edge_vpc.cidr_block]
    description = "Allows traffic from ${aws_vpc.edge_vpc.tags.Name} ingress to all protocols and ports"
  }

  tags = module.context_aws_security_group_ingress.tags
  lifecycle {
    prevent_destroy = false
  }
}
