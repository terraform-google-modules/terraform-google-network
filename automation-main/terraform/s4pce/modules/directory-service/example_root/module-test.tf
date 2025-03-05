/*
  Description: Test the module
  Comments:
*/

locals {
  directory_service_tags = merge(local.tags, {
    Name = "Directory Service Tags"
  })
  constrained_endpoint = {
    instance_profile = aws_iam_instance_profile.test.name
    key_name         = aws_key_pair.test.key_name
    subnet_id        = module.network.subnets["172.16.1.0/24"].id
    security_group_ids = [
      module.network.security_groups["base_egress"].id,
      module.network.security_groups["base_ingress"].id,
    ]
  }
  constrained_endpoint_route53 = {
    zone_id = aws_route53_zone.test.zone_id
    cname   = "constrained"
  }

  directory_service = {
    netbios        = "test"
    admin_password = "Password123!"
    fqdn           = "test.internal"
  }
  # NOTE: Values to use for import subnet test
  import_subnet_ids = [
    module.network.subnets["172.16.0.0/24"].id,
    module.network.subnets["172.16.1.0/24"].id,
  ]
  # NOTE: Values to use for create subnet test
  create_subnets = {
    az1a = { cidr_block = "172.16.2.0/24", az = "us-gov-west-1a" }
    az1b = { cidr_block = "172.16.3.0/24", az = "us-gov-west-1b" }
  }

  outbound_resolver = {
    security_group_ids = [
      module.network.security_groups["base_egress"].id,
      module.network.security_groups["base_ingress"].id,
    ]
    name = "test-dns-outbound-forwarder"
  }
}

module "test" {
  source                                  = "../"
  tags                                    = local.directory_service_tags
  create_cloudwatch_log_group             = false
  create_workspace_fullaccess_policy      = false
  create_constrained_endpoint             = false
  create_constrained_endpoint_dns_records = false
  create_outbound_resolver                = false

  directory_service        = local.directory_service
  directory_service_vpc_id = module.network.vpc.id
  directory_service_subnets = {
    # Mutually Exclusive Options
    create_subnets = local.create_subnets
    # import_subnet_ids = local.import_subnet_ids
  }

  # Following values may be omitted if "create" is false
  constrained_endpoint         = local.constrained_endpoint
  constrained_endpoint_route53 = local.constrained_endpoint_route53
  outbound_resolver            = local.outbound_resolver

  ### Hidden Advanced Variables
  ## These variables are not intended to be modified
  ## Limited support is provided for these variables, use at your own risk.
  ## Please see the terraform docs for a full list of advanced variables
}
output "module_test" { value = module.test }
