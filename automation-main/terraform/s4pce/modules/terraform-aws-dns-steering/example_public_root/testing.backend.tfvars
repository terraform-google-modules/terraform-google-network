/*
  Description: Terraform variables for initialization; The variables in this file are specifically for testing executions of the terraform module
  Comments:
    - Initialize with the following command. terraform init -backend-config=backend.tfvars.testing
*/

# This backend is used specifically for testing in the AWS Build account

##### Terraform iam-role backend configuration
region         = "us-east-2"
bucket         = "ns2-dev-build-terraform"
dynamodb_table = "ns2-dev-build-terraform"
key            = "test-user/terraform-aws-dns-steering"
