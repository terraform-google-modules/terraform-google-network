/*
  Description: Creates Metadata for Module
  Comments:
*/

module "base_layer_context" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = var.context
  module  = "terraform-aws-endpoint-multiport-multitarget"
}
