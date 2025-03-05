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
    #EXAMPLE_BACKEND_key            = "EXAMPLE0001/integrations/gardener/sftpgo/terraform.tfstate"
  }
}

##### Providers
provider "aws" {
  region = var.aws_region
  default_tags { tags = local.layer_tags }
}


##### Remote State Calls
### Customer
data "terraform_remote_state" "customer_layer_00" {
  backend = "s3"
  config = {
    encrypt        = true
    region         = "EXAMPLE_REGION"
    bucket         = "EXAMPLE_BUCKET"
    dynamodb_table = "EXAMPLE_DYNAMODB"
    key            = "EXAMPLE0001/layer-00/terraform.tfstate"
  }
}
data "terraform_remote_state" "customer_layer_02" {
  backend = "s3"
  config = {
    encrypt        = true
    region         = "EXAMPLE_REGION"
    bucket         = "EXAMPLE_BUCKET"
    dynamodb_table = "EXAMPLE_DYNAMODB"
    key            = "EXAMPLE0001/layer-02/terraform.tfstate"
  }
}
### Shoot
data "terraform_remote_state" "shoot_layer_00" {
  backend = "s3"
  config = {
    encrypt = true
    region  = "EXAMPLE_REGION"
    bucket  = "EXAMPLE_BUCKET"
    key     = "EXAMPLE_MANAGEMENT_KEY/integrations/gardener/shoot-vpc/layer-00/EXAMPLE_MANAGEMENT_WORKSPACE/terraform.tfstate"
  }
}
# Management
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
