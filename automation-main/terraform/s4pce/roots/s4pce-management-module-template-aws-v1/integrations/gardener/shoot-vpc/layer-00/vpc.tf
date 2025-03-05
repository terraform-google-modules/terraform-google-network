/*
  Description: Handles VPC creation; Creates VPC and updates DHCP options
  Layer: 00
  Dependencies: none
  Comments: N/A
*/

##### Shoot VPC

resource "aws_vpc" "shoot" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = "default"
  enable_dns_support               = true # NOTE: Gardener requires the VPC to have enabled DNS support
  enable_dns_hostnames             = true # NOTE: Gardener requires the VPC to have enabled DNS support
  assign_generated_ipv6_cidr_block = true # NOTE: Experimental (to us, anyways)
}
resource "aws_vpc_ipv4_cidr_block_association" "shoot_secondary_cidr" {
  vpc_id     = aws_vpc.shoot.id
  cidr_block = var.vpc_secondary_cidr_block
}


resource "aws_vpc_dhcp_options" "shoot" {
  domain_name = var.vpc_domain_name
  #domain_name         = module.module_context.domain.label_mapping["external"]["security_boundary"]
  domain_name_servers = ["AmazonProvidedDNS"]
  tags = { # NOTE: Not sure if this is a Gardener req or old AWS EKS req, see https://docs.aws.amazon.com/eks/latest/userguide/network_reqs.html
    Name                                                        = local.layer_resource_prefix
    "kubernetes.io/cluster/shoot-${local.base_resource_prefix}" = "1"
  }
}


resource "aws_vpc_dhcp_options_association" "vpc_dhcp_options_association" {
  vpc_id          = aws_vpc.shoot.id
  dhcp_options_id = aws_vpc_dhcp_options.shoot.id
}

##### Outputs
output "vpc_shoot" { value = {
  id                    = aws_vpc.shoot.id
  cidr_block            = aws_vpc.shoot.cidr_block
  dhcp_options_id       = aws_vpc_dhcp_options.shoot.id
  management_cidr_block = local.layer_00_outputs.vpc_main01.cidr_block
} }
