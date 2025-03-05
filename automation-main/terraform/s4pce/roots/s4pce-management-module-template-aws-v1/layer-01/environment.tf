/*
  Description: Declaration of providers, local variables, and backend remote state locations
  Comments: N/A
*/

### Backend
terraform {
  backend "s3" {
    encrypt              = true
    region               = "EXAMPLE_STATE_REGION"
    bucket               = "EXAMPLE_BUCKET"
    dynamodb_table       = "EXAMPLE_DYNAMODB"
    workspace_key_prefix = "EXAMPLE_MANAGEMENT_KEY/layer-01"
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

### Providers
provider "aws" {
  region = var.aws_region
}

### Remote State Calls
data "terraform_remote_state" "layer_00" {
  backend = "s3"
  config = {
    encrypt        = true
    region         = "EXAMPLE_STATE_REGION"
    bucket         = "EXAMPLE_BUCKET"
    dynamodb_table = "EXAMPLE_DYNAMODB"
    key            = "EXAMPLE_MANAGEMENT_KEY/layer-00/${terraform.workspace}/terraform.tfstate"
  }
}
