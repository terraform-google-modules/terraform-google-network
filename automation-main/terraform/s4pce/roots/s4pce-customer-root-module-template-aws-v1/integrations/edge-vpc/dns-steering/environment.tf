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
    #EXAMPLE_BACKEND_key            = "EXAMPLE0001/integrations/edge-vpc/dns-steering/terraform.tfstate"
  }
}

##### Providers
provider "aws" {
  region = var.aws_region # Because base_context ingests the aws_account this must be abstracted to a string.
}

provider "aws" {
  alias   = "dns_account"
  region  = var.dns_account_profile.region # Because base_context ingests the aws_account this must be abstracted to a string.
  profile = var.dns_account_profile.name
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
data "terraform_remote_state" "edge_vpc_layer_00" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE0001/integrations/edge-vpc/layer-00/terraform.tfstate"
  }
}
