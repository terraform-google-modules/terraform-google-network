/*
  Description: Metadata
  Comments: N/A
*/

##### AWS Account Information
data "aws_caller_identity" "current" {}

locals {
  base_context                = data.terraform_remote_state.layer_00.outputs._context
  layer_00_outputs            = data.terraform_remote_state.layer_00.outputs
  layer_01_outputs            = data.terraform_remote_state.layer_01.outputs
  layer_02_outputs            = data.terraform_remote_state.layer_02.outputs
  management_layer_00_outputs = data.terraform_remote_state.management_layer_00.outputs
  management_layer_01_outputs = data.terraform_remote_state.management_layer_01.outputs
}
