/*
  Description: Terraform input variables; Variables that should be changes on creation of a new IBP SAP Product Support VPC
  Comments:
    - The management_vpc_name should match the existing Management VPC in the account
    - vpc_custom_octet should be a unique CIDR block in the account
    - vpc_custom_name should be a unique CIDR block in the account
*/

##### AWS Variables
aws_region = "us-gov-west-1"
build_user = ""
