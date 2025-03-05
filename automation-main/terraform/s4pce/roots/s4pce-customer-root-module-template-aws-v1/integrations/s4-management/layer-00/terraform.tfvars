/*
  Description: Terraform input variables; Universal variables CRE S4-PCE customer####
  Comments:
    - Rename this file to terraform.tfvars to use
    - Uncomment and populate the missing variables before use
    - The management_vpc_name should match the existing Management VPC in the account
    - vpc_custom_octet should be a unique CIDR block in the account
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"

##### Add these values to your local.auto.tfvars
// build_user                                  = ""
