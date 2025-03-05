/*
  Description: Metadata generation
  Comments:
    - Filters for Gardener resources using tags (for example: 'kubernetes.io/cluster/...') that are created and managed by Gardener
    - These tags are generally predictable
*/

##### AWS
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

##### Outputs & Tagging
locals {
  ### Management locals
  management_layer_00_outputs = data.terraform_remote_state.management_layer_00.outputs
  management_layer_01_outputs = data.terraform_remote_state.management_layer_01.outputs
  ### Gardener Shoot locals
  shoot_layer_00_outputs = data.terraform_remote_state.shoot_layer_00.outputs
  ### Customer locals
  customer_layer_00_outputs = data.terraform_remote_state.customer_layer_00.outputs
  customer_layer_02_outputs = data.terraform_remote_state.customer_layer_02.outputs
  base_tags                 = data.terraform_remote_state.customer_layer_00.outputs._tags
  base_context              = data.terraform_remote_state.customer_layer_00.outputs._context
  base_resource_prefix      = data.terraform_remote_state.customer_layer_00.outputs._resource_prefix
  base_friendly_name        = data.terraform_remote_state.customer_layer_00.outputs._friendly_name
}

locals {
  layer_tags = merge(local.base_tags, {
    BusinessSubsection       = "pce"
    TerraformDeploymentLayer = "integrations/gardener/sftpgo"
    Name                     = "${local.base_resource_prefix}-sftpgo"
    Description              = "${local.base_friendly_name}-sftpgo"

    VPC = local.customer_layer_00_outputs.infrastructure.vpc_customer.id
  })
  layer_resource_prefix = "${local.base_resource_prefix}-sftpgo"
}
