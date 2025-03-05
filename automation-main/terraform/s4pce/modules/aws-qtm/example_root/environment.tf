/*
  Description: Backend settings required for the terraform module
  Comments:
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
