/*
  Description: Terraform variables for module run; The variables in this file are specifically for testing executions of the terraform module
  Comments:
    - Run the terraform module with this command: terraform apply -var-file=terraform.tfvars.testing
    - Destroy the terraform module with this command: terraform destroy -var-file=terraform.tfvars.testing
*/

aws_region = "us-gov-west-1"
build_user = "testuser"
