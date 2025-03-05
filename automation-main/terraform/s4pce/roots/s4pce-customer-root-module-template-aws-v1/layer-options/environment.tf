/*
  Description: Declaration of providers, local variables, and backend remote state locations
  Layer: 02
  Dependencies:
    layer-00: state
    layer-01: state

*/

###### Backend
terraform {
  backend "s3" {
    encrypt = true
    #EXAMPLE_BACKEND_region         = "EXAMPLE_REGION"
    #EXAMPLE_BACKEND_bucket         = "EXAMPLE_BUCKET"
    #EXAMPLE_BACKEND_dynamodb_table = "EXAMPLE_DYNAMODB"
    #EXAMPLE_BACKEND_key            = "EXAMPLE0001/layer-options/terraform.tfstate"
  }
}

##### Providers
provider "aws" {
  region = var.aws_region
}

locals {
  layer_00_outputs            = data.terraform_remote_state.layer_00.outputs
  layer_01_outputs            = data.terraform_remote_state.layer_01.outputs
  layer_02_outputs            = data.terraform_remote_state.layer_02.outputs
  management_layer_00_outputs = data.terraform_remote_state.management_layer_00.outputs
  management_layer_01_outputs = data.terraform_remote_state.management_layer_01.outputs
}

### Remote State Calls
data "terraform_remote_state" "layer_00" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE0001/layer-00/terraform.tfstate"
  }
}
data "terraform_remote_state" "layer_01" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE0001/layer-01/terraform.tfstate"
  }
}
data "terraform_remote_state" "layer_02" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE0001/layer-02/terraform.tfstate"
  }
}
data "terraform_remote_state" "management_layer_00" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE_MANAGEMENT_KEY/layer-00/EXAMPLE_MANAGEMENT_WORKSPACE/terraform.tfstate"
  }
}
data "terraform_remote_state" "management_layer_01" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE_MANAGEMENT_KEY/layer-01/EXAMPLE_MANAGEMENT_WORKSPACE/terraform.tfstate"
  }
}
