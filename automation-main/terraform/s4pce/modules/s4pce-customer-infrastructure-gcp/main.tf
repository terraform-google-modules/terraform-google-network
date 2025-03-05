/*
  Description: General Terraform metadata and null context
  Comments:
*/

data "google_project" "current" {}

##### Detect Module Version
data "local_file" "changelog" {
  filename = "${path.module}/CHANGELOG-NS2.md"
}

locals {
  changelog_version = regex(
    "# Latest Version\\n([\\d\\.]+)\\n",
    data.local_file.changelog.content
  )[0]
}


##### Context
locals {
  module_name = "s4pce-customer-infrastructure-gcp"
}

module "module_context" {
  source  = "../terraform-null-context/modules/legacy"
  context = var.context

  module         = local.module_name
  module_version = local.changelog_version
}
