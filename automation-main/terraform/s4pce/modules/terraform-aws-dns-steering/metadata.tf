/*
  Description: General Terraform metadata and null context
  Comments:
*/


data "local_file" "changelog" {
  filename = "${path.module}/CHANGELOG-SCS.md"
}

locals {
  changelog_version = regex(
    "# Latest Version\\n([\\d\\.]+)\\n",
    data.local_file.changelog.content
  )[0]
  module_name = "terraform-aws-dns-steering"
}

module "module_context" {
  source         = "../../../shared/modules/terraform-null-context/modules/legacy"
  context        = var.context
  module         = local.module_name
  module_version = local.changelog_version
}
