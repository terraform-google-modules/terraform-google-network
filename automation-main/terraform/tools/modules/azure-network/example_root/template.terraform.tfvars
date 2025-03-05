/*
  Description: Terraform variables for module run; The variables contained in this page will be used to run this terraform module.
  Comments:
    - Run the terraform module with this command: terraform apply -var-file=terraform.tfvars.testing
    - Destroy the terraform module with this command: terraform destroy -var-file=terraform.tfvars.testing
*/

azure_environment     = "AZURE_ENVIRONMENT"
azure_subscription_id = "AZURE_SUBSCRIPTION_ID"
build_user            = "testuser"
