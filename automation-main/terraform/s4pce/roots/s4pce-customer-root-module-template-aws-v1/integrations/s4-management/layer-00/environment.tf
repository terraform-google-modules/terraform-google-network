/*
  Description: Declaration of providers, local variables, and backend remote state locations
  Layer: 00
*/

###### Backend
terraform {
  backend "s3" {
    encrypt = true
    #EXAMPLE_BACKEND_region         = "EXAMPLE_REGION"
    #EXAMPLE_BACKEND_bucket         = "EXAMPLE_BUCKET"
    #EXAMPLE_BACKEND_dynamodb_table = "EXAMPLE_DYNAMODB"
    #EXAMPLE_BACKEND_key            = "EXAMPLE0001/integrations/s4-management/layer-00/terraform.tfstate"
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
    key     = "EXAMPLE_MANAGEMENT_KEY/layer-00/EXAMPLE_MANAGEMENT_WORKSPACE/terraform.tfstate"
  }
}
