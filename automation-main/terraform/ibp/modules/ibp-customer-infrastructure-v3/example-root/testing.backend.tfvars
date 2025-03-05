/*
  Description: Terraform variables for initialization; The variables in this file are specifically for testing executions of the terraform module
  Comments:
    - Initialize with the following command. terraform init -backend-config=backend.tfvars.testing
*/

# This backend is used specifically for testing in the AWS Build account

##### Terraform iam-role backend configuration
region         = "us-gov-west-1"
bucket         = "ibp-development-terraform"
dynamodb_table = "ibp-terraform"
key            = "test-user/ibp-customer-infrastructure-v3/terraform.tfstate"
