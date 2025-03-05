/*
  Description: Declaration of providers, local variables, and backend remote state locations
  Comments: N/A
*/

###### Backend
terraform {
  backend "s3" {
    encrypt        = true
    region         = "EXAMPLE_STATE_REGION"
    bucket         = "EXAMPLE_BUCKET"
    dynamodb_table = "EXAMPLE_DYNAMODB"
    key            = "EXAMPLE_MANAGEMENT_KEY/integrations/sms/layer-00/terraform.tfstate"
  }
}
