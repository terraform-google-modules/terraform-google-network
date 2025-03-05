/*
  Description: Backend settings required for the terraform module
  Comments: The contents of this file should not be modified by Operators.
*/

###### Backend
terraform {
  backend "s3" {
    encrypt = true

    # The remainder of the configurations are read in from backend.tfvars
    # For more detailed instructions on how to properly configure the backend, please refer to the README.md documentation.
  }
}


##### Providers
provider "aws" {
  region = var.aws_region
}

provider "null" {}
locals {
  layer00 = data.terraform_remote_state.layer_00.outputs
}
### Remote State Calls
data "terraform_remote_state" "layer_00" {
  backend = "s3"
  config = {
    encrypt = true
    region  = var.aws_region
    bucket  = var.bucket
    key     = var.key
  }
}
