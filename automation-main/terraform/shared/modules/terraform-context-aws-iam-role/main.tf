/*
  Description: Creates context and other metadata
  Comments: N/A
*/


module "base_layer_context" {
  source  = "../../modules/terraform-null-context/modules/legacy"
  context = var.context
}
