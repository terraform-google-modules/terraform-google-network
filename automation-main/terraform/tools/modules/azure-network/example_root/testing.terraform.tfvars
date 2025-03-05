/*
  Description: Terraform variables for module run; The variables in this file are specifically for testing executions of the terraform module
  Comments:
    - Run the terraform module with this command: terraform apply -var-file=terraform.tfvars.testing
    - Destroy the terraform module with this command: terraform destroy -var-file=terraform.tfvars.testing
*/



azure_environment     = "usgovernment"
azure_subscription_id = "ec477f00-3632-495f-8a99-3ad5568024d8"
build_user            = "testuser"
