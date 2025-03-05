/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
  Comments:
    - N/A
*/

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

##### Metadata
locals {
  base_context                = data.terraform_remote_state.layer_00.outputs._context
  layer_00_outputs            = data.terraform_remote_state.layer_00.outputs
  layer_01_outputs            = data.terraform_remote_state.layer_01.outputs
  layer_02_outputs            = data.terraform_remote_state.layer_02.outputs
  management_layer_01_outputs = data.terraform_remote_state.management_layer_01.outputs
}
module "base_layer_context" {
  source     = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  build_user = var.build_user
  context    = local.base_context
  custom_values = {
    locals = null
    tags = [
      {
        name     = "VPC"
        value    = "vpc"
        required = true
      }
    ]
    kv = {
      vpc              = "${local.base_context.security_boundary}-${local.base_context.business}-${local.base_context.customer}"
      deployment_layer = "layer-ha"
    }
  }
}


locals {
  instance_key_list = concat(var.overlay_ip_instances.*.instance_key, var.secondarydbs)
  instance_arn_list = [
    for key, value in local.instance_key_list :
    local.layer_02_outputs.instance_list[value].instance_arn
  ]

  route_table_ids = [
    local.layer_00_outputs.infrastructure.route_table_customer_ngw1a.id,
    local.layer_00_outputs.infrastructure.route_table_customer_ngw1b.id,
    local.layer_00_outputs.infrastructure.route_table_customer_ngw1c.id
  ]
  rt_arns = [
    for e in local.route_table_ids :
    "arn:${data.aws_partition.current.partition}:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:route-table/${e}"
  ]
}


output "route_table_ids" { value = {
  customer_vpc_route_table_id_1a = local.layer_00_outputs.infrastructure.route_table_customer_ngw1a.id
  customer_vpc_route_table_id_1b = local.layer_00_outputs.infrastructure.route_table_customer_ngw1b.id
  customer_vpc_route_table_id_1c = local.layer_00_outputs.infrastructure.route_table_customer_ngw1c.id
} }

data "aws_instance" "instance_info" {
  for_each    = toset(local.instance_key_list)
  instance_id = local.layer_02_outputs.instance_list[each.value].instance_id
}

locals {
  overlay_ip_list = flatten([
    for key, value in ["ngw1a", "ngw1b", "ngw1c"] : [
      for subkey, subvalue in var.overlay_ip_instances : {
        instance_key = subvalue.instance_key
        overlay_ip   = subvalue.overlay_ip
        ngw          = value
  }]])
  overlay_ip_map = {
    for key, value in local.overlay_ip_list : "${value.instance_key}_${value.ngw}" => value
  }
}
