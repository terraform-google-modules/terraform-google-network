/*
  Description: Collects Metadata for VPC integration
  Comments: N/A
*/

module "aws_list_workspaces" {
  source = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-aws-list-workspaces"

  s3_bucket_name = "EXAMPLE_BUCKET"
  folder_path    = "EXAMPLE_MANAGEMENT_KEY/layer-00"
}

locals {
  management_workspaces = module.aws_list_workspaces.workspaces
  init_outputs          = data.terraform_remote_state.init.outputs
}

data "terraform_remote_state" "init" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_STATE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE_MANAGEMENT_KEY/init/terraform.tfstate"
  }
}

data "terraform_remote_state" "management" {
  for_each = toset(local.management_workspaces)

  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_STATE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE_MANAGEMENT_KEY/layer-00/${each.key}/terraform.tfstate"
  }
}

locals {
  management_outputs = {
    for workspace in local.management_workspaces : workspace => data.terraform_remote_state.management[workspace].outputs
  }
  management_edge_subnets_list = {
    for workspace in local.management_workspaces : workspace => flatten([
      {
        id   = local.management_outputs[workspace].subnet_main01_edge_1a.id
        name = local.management_outputs[workspace].subnet_main01_edge_1a.name
      },
      {
        id   = local.management_outputs[workspace].subnet_main01_edge_1b.id
        name = local.management_outputs[workspace].subnet_main01_edge_1b.name
      },
      {
        id   = local.management_outputs[workspace].subnet_main01_edge_1c.id
        name = local.management_outputs[workspace].subnet_main01_edge_1c.name
      },
    ])
  }

  management_integration_security_groups = {
    for workspace in local.management_workspaces : workspace => {
      (local.management_outputs[workspace].security_group_main01_vpc.name) : {
        id = local.management_outputs[workspace].security_group_main01_vpc.id
        rules = {
          "all-ingress" : {
            direction   = "ingress", protocol = "all", from_port = "0", to_port = "0",
            description = "Allows ingress traffic to all protocols and ports"
          }
          "all-egress" : {
            direction   = "egress", protocol = "all", from_port = "0", to_port = "0",
            description = "Allows egress traffic to all protocols and ports"
          }
        }
      }
    }
  }

  management_integration_route_tables = {
    for workspace in local.management_workspaces : workspace => merge(
      { (local.management_outputs[workspace].route_table_main01_default.name) : local.management_outputs[workspace].route_table_main01_default.id },
      { (local.management_outputs[workspace].route_table_main01_nat_edge_1a.name) : local.management_outputs[workspace].route_table_main01_nat_edge_1a.id },
      { (local.management_outputs[workspace].route_table_main01_nat_edge_1b.name) : local.management_outputs[workspace].route_table_main01_nat_edge_1b.id },
      { (local.management_outputs[workspace].route_table_main01_nat_edge_1c.name) : local.management_outputs[workspace].route_table_main01_nat_edge_1c.id },
    )
  }

  management_integration_subnets = {
    for workspace in local.management_workspaces : workspace => {
      for subnet in local.management_edge_subnets_list[workspace] : subnet.name => subnet.id
    }
  }

  management_network_integration = {
    for workspace in local.management_workspaces :
    (local.management_outputs[workspace].vpc_main01.name) => {
      friendly_name = local.management_outputs[workspace]._context.environment_values.kv.prefix_friendly_name
      vpcs = {
        (local.management_outputs[workspace].vpc_main01.name) = {
          id              = local.management_outputs[workspace].vpc_main01.id
          cidr            = local.management_outputs[workspace].vpc_main01.cidr_block
          region          = local.management_outputs[workspace]._context.region
          description     = local.management_outputs[workspace].vpc_main01.description
          subnets         = local.management_integration_subnets[workspace]
          route_tables    = local.management_integration_route_tables[workspace]
          security_groups = local.management_integration_security_groups[workspace]
        }
      }
      additional_propagated_vpcs   = []
      additional_static_vpc_routes = []
    }
  }
}
