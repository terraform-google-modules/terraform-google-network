/*
  Description: Backend settings required to setup IBP Customer VPC; Declaration of providers, local variables, and backend remote state locations
  Comments: The contents of this file should not be modified by Operators.
*/

###### Backend
terraform {
  backend "s3" {
    encrypt = true
    #EXAMPLE_BACKEND_region         = "EXAMPLE_REGION"
    #EXAMPLE_BACKEND_bucket         = "EXAMPLE_BUCKET"
    #EXAMPLE_BACKEND_dynamodb_table = "EXAMPLE_DYNAMODB"
    #EXAMPLE_BACKEND_key            = "EXAMPLE0001/integrations/EXAMPLE_MANAGEMENT_KEY/layer-00/terraform.tfstate"
  }
}

##### Providers
provider "aws" {
  region = var.aws_region
}

### Remote State Calls
data "terraform_remote_state" "layer_00" {
  backend = "s3"
  config = {
    encrypt        = true
    region         = "EXAMPLE_REGION"
    bucket         = "EXAMPLE_BUCKET"
    dynamodb_table = "EXAMPLE_DYNAMODB"
    key            = "EXAMPLE0001/layer-00/terraform.tfstate"
  }
}
data "terraform_remote_state" "management_layer_00" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE_MANAGEMENT_KEY/layer-00/terraform.tfstate"
  }
}
data "terraform_remote_state" "management_layer_options" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE_MANAGEMENT_KEY/layer-options/terraform.tfstate"
  }
}

locals {
  layer_00_outputs                 = data.terraform_remote_state.layer_00.outputs
  management_layer_00_outputs      = data.terraform_remote_state.management_layer_00.outputs
  management_layer_options_outputs = data.terraform_remote_state.management_layer_options.outputs
}
