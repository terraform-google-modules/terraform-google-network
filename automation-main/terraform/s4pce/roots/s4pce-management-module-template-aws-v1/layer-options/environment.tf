/*
  Description: This is standard environment and metadata provided for all customizations.
  Comments:
*/

### Backend
terraform {
  backend "s3" {
    encrypt              = true
    region               = "EXAMPLE_STATE_REGION"
    bucket               = "EXAMPLE_BUCKET"
    dynamodb_table       = "EXAMPLE_DYNAMODB"
    workspace_key_prefix = "EXAMPLE_MANAGEMENT_KEY/layer-options"
    key                  = "terraform.tfstate"
  }
}

### Providers
provider "aws" {
  region = var.aws_region
  default_tags {
    tags = merge(local.layer_00_outputs._tags, {
      "TerraformDeploymentLayer" = "layer-options"
    })
  }
}


locals {
  layer_00_outputs = data.terraform_remote_state.layer_00.outputs
  layer_01_outputs = data.terraform_remote_state.layer_01.outputs
  layer_02_outputs = data.terraform_remote_state.layer_02.outputs
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
data "terraform_remote_state" "layer_01" {
  backend = "s3"
  config = {
    encrypt        = true
    region         = "EXAMPLE_STATE_REGION"
    bucket         = "EXAMPLE_BUCKET"
    dynamodb_table = "EXAMPLE_DYNAMODB"
    key            = "EXAMPLE_MANAGEMENT_KEY/layer-01/${terraform.workspace}/terraform.tfstate"
  }
}
data "terraform_remote_state" "layer_02" {
  backend = "s3"
  config = {
    encrypt        = true
    region         = "EXAMPLE_STATE_REGION"
    bucket         = "EXAMPLE_BUCKET"
    dynamodb_table = "EXAMPLE_DYNAMODB"
    key            = "EXAMPLE_MANAGEMENT_KEY/layer-02/${terraform.workspace}/terraform.tfstate"
  }
}
