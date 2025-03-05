/*
  Description: Metadata generation
  Comments:
*/

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

locals {
  layer_00_outputs     = data.terraform_remote_state.layer_00.outputs
  base_tags            = data.terraform_remote_state.layer_00.outputs._tags
  base_resource_prefix = data.terraform_remote_state.layer_00.outputs._resource_prefix
  base_friendly_name   = data.terraform_remote_state.layer_00.outputs._friendly_name
}

locals {
  layer_tags = merge(local.base_tags, {
    BusinessSubsection       = "pce"
    TerraformDeploymentLayer = "integrations/gardener/shoot-vpc/layer-00"
    Name                     = "${local.base_resource_prefix}-shoot"
    Description              = "${local.base_friendly_name}-shoot"

    VPC = var.vpc_name
  })
  layer_resource_prefix = "${local.base_resource_prefix}-shoot"
}
