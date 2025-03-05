/*
  Description: Backend settings required for module setup; Declaration of providers, local variables, and backend remote state locations
  Layer: 00
  Comments:
*/

### Backend
terraform {
  backend "s3" {
    encrypt = true
    #EXAMPLE_BACKEND_region         = "EXAMPLE_REGION"
    #EXAMPLE_BACKEND_bucket         = "EXAMPLE_BUCKET"
    #EXAMPLE_BACKEND_dynamodb_table = "EXAMPLE_DYNAMODB"
    #EXAMPLE_BACKEND_key            = "EXAMPLE0001/integrations/aws-ibp-peer/layer-00/terraform.tfstate"
  }
}

##### Providers
provider "aws" {
  region = var.aws_region # Because base_context ingests the aws_account this must be abstracted to a string.
}
provider "aws" {
  alias   = "ibp"
  region  = "EXAMPLE_REGION"
  profile = var.ibp_profile
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

data "terraform_remote_state" "ibp" {
  backend = "s3"
  config = {
    profile = var.ibp_profile
    encrypt = true
    region  = "EXAMPLE_REGION"
    bucket  = var.ibp_bucket
    key     = "${var.ibp_customer}/layer-00/terraform.tfstate"
  }
}
