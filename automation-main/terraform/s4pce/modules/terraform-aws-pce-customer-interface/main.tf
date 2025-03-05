/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
  Comments:
    - N/A
*/

data "local_file" "changelog" {
  filename = "${path.module}/CHANGELOG-SCS.md"
}

locals {
  logging_regions   = var.logging_regions == null ? [module.base_layer_context.region] : var.logging_regions
  changelog_version = regex("# Latest Version\\n([\\d\\.]+)\\n", data.local_file.changelog.content)[0]
}

module "base_layer_context" {
  source         = "../../../shared/modules/terraform-null-context/modules/legacy"
  context        = var.context
  module         = "aws-customer-interface"
  module_version = local.changelog_version

}
