/*
  Description: General Terraform metadata and null context
  Comments:
*/

module "base_layer_context" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = var.context
}
