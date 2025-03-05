/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
*/

##### Detect Module Version
data "local_file" "changelog" {
  filename = "${path.module}/CHANGELOG-SCS.md"
}

locals {
  changelog_version = regex(
    "# Latest Version\\n([\\d\\.]+) \\(([\\d\\.]+)-([\\d]+)\\)\\n",
    data.local_file.changelog.content
  )[0]
}

##### Context
locals {
  module_name    = "azure-linux-virtual-machine"
  context_passed = var.context != null ? true : false
}

module "module_context" {
  source  = "../terraform-null-context/modules/legacy"
  count   = local.context_passed ? 1 : 0
  context = var.context

  module         = local.module_name
  module_version = local.changelog_version
}

##### Force a module dependency if wanted
resource "null_resource" "module_dependency" {
  triggers = {
    dependency = var.module_dependency
  }
}

##### Global Local Variables and Resources
data "azurerm_subscription" "current" {}

### Generate a Random Name for the virtual machine
resource "random_id" "instance" {
  prefix = "${coalesce(var.name, try(module.module_context[0].additional_tags.Name, "NULL"))}/"
  # Generate a new ID if any of these values change.
  keepers = {
    admin_username = var.admin_username
    public_key     = var.public_key
    zone           = var.zone
  }
  byte_length = 8

  lifecycle {
    create_before_destroy = true
  }
}

### Enforce Mandatory Tags
locals {
  errors = {
    MISSING_MANDATORY_TAG_Description = null
    MISSING_MANDATORY_TAG_Name        = null
    MISSING_MANDATORY_TAG_ProductName = null
  }

  tag_description_check  = coalesce(var.tag_description, try(module.module_context[0].additional_tags.Description, ""), "FAIL")
  _tag_description_check = local.tag_description_check == "FAIL" ? concat([], local.errors.MISSING_MANDATORY_TAG_Description) : []

  tag_name_check  = coalesce(var.name, try(module.module_context[0].additional_tags.Name, ""), "FAIL")
  _tag_name_check = local.tag_name_check == "FAIL" ? concat([], local.errors.MISSING_MANDATORY_TAG_Name) : []

  tag_productname_check  = coalesce(var.tag_productname, try(module.module_context[0].additional_tags.ProductName, ""), "FAIL")
  _tag_productname_check = local.tag_productname_check == "FAIL" ? concat([], local.errors.MISSING_MANDATORY_TAG_ProductName) : []
}
