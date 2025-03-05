/*
  Description: Backend settings required to setup the module; Declaration of providers, local variables, and backend remote state locations
  Comments:
    - This module is designed to have additional tasks added.  Simply add new task files as needed and control
      them with the apprpropriate value in the local variable "instance_map_actual"
*/

##### Get AWS Account Metadata
data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

# Get subnet metadata to discover VPC
data "aws_subnet" "instance" {
  id = var.subnet_id
}
# Get VPC metadata to discover VPC names
data "aws_vpc" "instance" {
  id = data.aws_subnet.instance.vpc_id
}

##### Force a module dependency if wanted
resource "null_resource" "module_dependency" {
  triggers = {
    dependency = var.module_dependency
  }
}

##### Generate a Random Name for the instance
resource "random_id" "instance" {
  # prefix = local.context_passed ? "${coalesce(var.tag_name, module.module_context[0].custom_values.kv.name)}/" : "${var.tag_name}/"
  prefix = "${coalesce(var.tag_name, try(module.module_context[0].additional_tags.Name, "NULL"))}/"
  # Generate a new ID if any of these values change.
  keepers = {
    key_name                    = var.ec2_key
    subnet_id                   = var.subnet_id
    associate_public_ip_address = var.associate_public_ip_address || var.associate_elastic_ip_address
  }
  byte_length = 8

  lifecycle {
    create_before_destroy = true
  }
}

##### Context Logic
data "local_file" "changelog" {
  filename = "${path.module}/CHANGELOG-NS2.md"
}

locals {
  context_passed = var.context != null ? true : false
  changelog_version = regex(
    "# Latest Version\\n([\\d\\.]+) \\(([\\d\\.]+)-([\\d]+)\\)\\n",
    data.local_file.changelog.content
  )[0]
}

module "module_context" {
  source  = "../terraform-null-context/modules/legacy"
  count   = local.context_passed ? 1 : 0
  context = var.context

  module         = "aws-instance"
  module_version = local.changelog_version
}

##### Enforce Mandatory Tags
locals {
  errors = {
    MISSING_MANDATORY_TAG_Description = null
    MISSING_MANDATORY_TAG_Name        = null
    MISSING_MANDATORY_TAG_ProductName = null
  }

  tag_description_check  = coalesce(var.tag_description, try(module.module_context[0].additional_tags.Description, ""), "FAIL")
  _tag_description_check = local.tag_description_check == "FAIL" ? concat([], local.errors.MISSING_MANDATORY_TAG_Description) : []

  tag_name_check  = coalesce(var.tag_name, try(module.module_context[0].additional_tags.Name, ""), "FAIL")
  _tag_name_check = local.tag_name_check == "FAIL" ? concat([], local.errors.MISSING_MANDATORY_TAG_Name) : []

  tag_productname_check  = coalesce(var.tag_productname, try(module.module_context[0].additional_tags.ProductName, ""), "FAIL")
  _tag_productname_check = local.tag_productname_check == "FAIL" ? concat([], local.errors.MISSING_MANDATORY_TAG_ProductName) : []
}
