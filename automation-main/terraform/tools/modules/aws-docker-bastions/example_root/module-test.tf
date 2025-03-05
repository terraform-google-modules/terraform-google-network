/*
  Description: Test the module
  Comments:
*/


data "aws_ami" "instance" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Golden-SCS-Ubuntu-20.04-Base-V*"]
  }
  owners = ["156506675147"]
}

locals {
  docker_bastion_list = ["test-user1"]
}

module "test" {
  source              = "../"
  build_user          = "test-user1"                               # Required, Build User to tag the resources
  tags                = local.tags                                 # Optional, Tags to apply to the resources
  docker_bastion_list = local.docker_bastion_list                  # Required, List of named bastions to create
  key_name            = aws_key_pair.key.key_name                  # Required, Key pair name to use for the bastions
  subnet_id           = module.network.subnets["172.16.1.0/24"].id # Required, Subnet ID to deploy the bastions
  image_ubuntu        = data.aws_ami.instance.id                   # Required, Ubuntu AMI to use
  security_groups = [                                              # Required, List of security groups to apply to the bastions
    module.network.security_groups["base_egress"].id,
    module.network.security_groups["base_ingress"].id,
  ]
  # adv_vm_size = "t3a.small"                             # Advanced Variable allowing a size other than t3a.small
  # adv_iam_instance_profile = null                       # Advanced Variable allowing an IAM Profile to be attached
  # adv_public_ip = true                                  # Advanced Variable allowing Public Access.  See Security Rules Below
}
output "module_test" { value = module.test }

# # For Testing public access, expose with Public IP and allow ingress from the current IP
# data "http" "my_ip" {
#   url = "http://checkip.amazonaws.com/"
# }
# resource "aws_vpc_security_group_ingress_rule" "allow_test_ingress" {
#   security_group_id = module.network.security_groups["base_ingress"].id
#   ip_protocol       = "-1"
#   cidr_ipv4         = "${chomp(data.http.my_ip.response_body)}/32"
#   description       = "allow_test_ingress"
# }
