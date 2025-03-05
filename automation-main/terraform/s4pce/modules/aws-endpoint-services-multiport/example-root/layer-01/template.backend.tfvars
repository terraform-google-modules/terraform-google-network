/*
  Description: Terraform variables for initialization; The variables contained in this page will be used to initialize this terraform module.
  Comments:
    - Copy the template file to backend.tfvars
    - Substitute the variables with the correct values.
    - Initialize with the following command. terraform init -backend-config=backend.tfvars
*/

##### Terraform iam-role backend configuration
region = "us-gov-west-1" # AWS region
# bucket           = "YOUR AWS S3 BUCKET NAME"                 # AWS S3 bucket to store terraform backend
# dynamodb_table   = "YOUR AWS DYNAMODB TABLE NAME"            # AWS DynamoDB table to store lock for terraform backend statefile
# key              = "YOUR PATH TO STORE .tfstate FILE IN S3"  # The path within the S3 bucket to store backend statefile for this terraform configuration
