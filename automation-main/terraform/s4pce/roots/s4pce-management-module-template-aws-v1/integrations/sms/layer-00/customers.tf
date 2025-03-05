/*
  Description: Collects Metadata for VPC integration
  Comments: N/A
*/

data "terraform_remote_state" "customer" {
  for_each = toset(var.customer_list)
  backend  = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_STATE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "${each.key}/layer-00/terraform.tfstate"
  }
}

locals {
  customer_output = { for key in var.customer_list : key => data.terraform_remote_state.customer[key].outputs }
  customer_edge_subnets_list = { for key in var.customer_list : key => flatten([
    {
      id   = local.customer_output[key].infrastructure.subnet_edge_1a.id
      name = local.customer_output[key].infrastructure.subnet_edge_1a.name
    },
    {
      id   = local.customer_output[key].infrastructure.subnet_edge_1b.id
      name = local.customer_output[key].infrastructure.subnet_edge_1b.name
    },
    {
      id   = local.customer_output[key].infrastructure.subnet_edge_1c.id
      name = local.customer_output[key].infrastructure.subnet_edge_1c.name
    },
  ]) }

  customer_integration_security_groups = { for key in var.customer_list : key => {
    (local.customer_output[key].infrastructure.security_group_customer_access_management.name) : {
      id = local.customer_output[key].infrastructure.security_group_customer_access_management.id
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
  } }

  customer_integration_route_tables = { for key in var.customer_list : key => merge(
    { (local.customer_output[key].infrastructure.route_table_default.name) : local.customer_output[key].infrastructure.route_table_default.id },
    { (local.customer_output[key].infrastructure.route_table_customer_ngw1a.name) : local.customer_output[key].infrastructure.route_table_customer_ngw1a.id },
    { (local.customer_output[key].infrastructure.route_table_customer_ngw1b.name) : local.customer_output[key].infrastructure.route_table_customer_ngw1b.id },
    { (local.customer_output[key].infrastructure.route_table_customer_ngw1c.name) : local.customer_output[key].infrastructure.route_table_customer_ngw1c.id },
  ) }

  customer_integration_subnets = { for key in var.customer_list : key => {
    for subnet in local.customer_edge_subnets_list[key] : subnet.name => subnet.id
  } }

  customer_network_integration = {
    for key in var.customer_list : (local.customer_output[key].infrastructure.vpc_customer.name) => {
      friendly_name = local.customer_output[key]._context.environment_values.kv.prefix_friendly_name
      vpcs = {
        (local.customer_output[key].infrastructure.vpc_customer.name) = {
          id              = local.customer_output[key].infrastructure.vpc_customer.id
          cidr            = local.customer_output[key].infrastructure.vpc_customer.cidr_block
          region          = local.customer_output[key]._context.region
          description     = local.customer_output[key].infrastructure.vpc_customer.description
          subnets         = local.customer_integration_subnets[key]
          route_tables    = local.customer_integration_route_tables[key]
          security_groups = local.customer_integration_security_groups[key]
        }
      }
      additional_propagated_vpcs   = []
      additional_static_vpc_routes = []
    }
  }
}
