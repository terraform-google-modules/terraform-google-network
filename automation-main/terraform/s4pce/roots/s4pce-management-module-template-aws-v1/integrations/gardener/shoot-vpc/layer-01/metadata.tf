/*
  Description: Metadata generation
  Comments:
*/

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  layer_00_outputs = data.terraform_remote_state.layer_00.outputs
}

##### Resources Filtered by Tag
# TODO: Will evaluate which subnets to filter OUT from these - maybe the public subnets?

### Gardener Managed Subnets
data "aws_subnets" "gardener_managed_subnets" {
  filter {
    name   = "vpc-id"
    values = [local.layer_00_outputs.vpc_shoot.id]
  }
  tags = {
    "kubernetes.io/cluster/shoot--${var.gardener_project_name}--${var.gardener_shoot_cluster_name}" = 1
  }
}

### Gardener Managed Route Tables
data "aws_route_table" "gardener_managed_route_tables" {
  for_each  = toset(data.aws_subnets.gardener_managed_subnets.ids)
  subnet_id = each.value
}

locals {
  gardener_managed_subnets = data.aws_subnets.gardener_managed_subnets # All subnets that are managed by Gardener
  gardener_managed_route_tables = toset(
    distinct(
      [for route_table in data.aws_route_table.gardener_managed_route_tables : route_table.route_table_id]
  )) # All distinct route tables associated with the subnets managed by Gardener
}


##### Outputs
output "gardener_managed_subnets" { value = local.gardener_managed_subnets.ids }
output "gardener_managed_route_tables" { value = local.gardener_managed_route_tables }
