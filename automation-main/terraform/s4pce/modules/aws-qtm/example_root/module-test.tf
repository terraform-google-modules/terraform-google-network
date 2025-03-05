/*
  Description: Test the module
  Comments: Example Usage. Please see the Modules Terraform Docs for full description
*/



locals {
  context = module.context.context
  # vpc_info = module.network.vpc # Alternate way to pass values.
  vpc_info = {
    id         = module.network.vpc.id
    cidr_block = module.network.vpc.cidr_block
  }
  subnet_info = {
    id = module.network.subnets["172.16.0.0/24"].id
  }
  vm_values = {
    qtm_database = {
      instance_type = "t3.micro" # `r5.8xlarge` is considered default for SAP
      meta_key_name = "dbqt"
    }
    qtm_application = {
      instance_type = "t3.micro" # `m5.xlarge` is considered default for SAP
      meta_key_name = "app01qta"
    }
    qtm_webdispatcher = {
      instance_type = "t3.micro" # `m5.large` is considered default for SAP
      meta_key_name = "app01ww1"
    }
  }
  ec2_key              = aws_key_pair.test_env.key_name
  egress_cidrs         = { "example" = "192.168.0.1/32" }
  iam_instance_profile = aws_iam_instance_profile.test_env.id
  alb_info = {
    subnet_mappings = [
      module.network.subnets["172.16.0.0/24"].id,
      module.network.subnets["172.16.1.0/24"].id,
    ]
    certificate_arn = aws_acm_certificate.test_env.arn
  }
}

module "qtm_dev" {
  source               = "../"
  build_user           = var.build_user
  tags                 = local.tags
  context              = local.context
  vpc_info             = local.vpc_info
  subnet_info          = local.subnet_info
  vm_values            = local.vm_values
  ec2_key              = local.ec2_key
  egress_cidrs         = local.egress_cidrs
  iam_instance_profile = local.iam_instance_profile
  alb_info             = local.alb_info
  # Optional Values, see Docs for more information
  # adv_random_prefix = "test"
  # adv_image_database = {}
  # adv_image_application = {}
  # adv_alb_ingress_cidrs = { alb_ingress = "192.168.0.0/24"}
}

output "module" {
  value = module.qtm_dev
}
