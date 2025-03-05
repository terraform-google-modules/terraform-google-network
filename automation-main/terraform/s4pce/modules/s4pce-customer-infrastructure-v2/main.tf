/*
  Description: General Terraform metadata and null context
  Comments:
*/

resource "null_resource" "module_dependency" {
  triggers = {
    dependency = var.module_dependency
  }
}

module "base_layer_context" {
  source  = "../../../shared/modules/terraform-null-context/modules/legacy"
  context = var.context
}
