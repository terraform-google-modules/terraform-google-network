/*
  Description: Declaration of Backend and Providers
  Comments:
*/

### Backend
terraform {
  backend "s3" {
    encrypt        = true
    region         = "EXAMPLE_STATE_REGION"
    bucket         = "EXAMPLE_BUCKET"
    dynamodb_table = "EXAMPLE_DYNAMODB"
    key            = "EXAMPLE_MANAGEMENT_KEY/init/terraform.tfstate"
  }
}

### Providers
provider "aws" {
  region = var.aws_region
}
