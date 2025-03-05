/*
  Description: Declaration of Backend and Providers
  Comments:
*/

### Backend
terraform {
  backend "s3" {
    encrypt              = true
    region               = "EXAMPLE_STATE_REGION"
    bucket               = "EXAMPLE_BUCKET"
    dynamodb_table       = "EXAMPLE_DYNAMODB"
    workspace_key_prefix = "EXAMPLE_MANAGEMENT_KEY/layer-00"
    key                  = "terraform.tfstate"
  }
}

locals {
  provider_errors = {
    NOT_DESIGNED_FOR_DEFAULT_WORKSPACE = null
  }
  default_workspace_check = terraform.workspace != "default" ? concat([], []) : concat([],
    local.provider_errors.NOT_DESIGNED_FOR_DEFAULT_WORKSPACE
  )
}

##### Providers
provider "aws" {
  region = var.aws_region # Because base_context ingests the aws_account this must be abstracted to a string.
}
