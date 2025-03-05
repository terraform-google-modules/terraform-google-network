/*
  Description: Terraform variables for initialization; The variables in this file are specifically for testing executions of the terraform module
  Comments:
    - Initialize with the following command. terraform init -backend-config=testing.backend.tfvars
*/

##### Terraform iam-role backend configuration
environment          = "usgovernment"
subscription_id      = "ec477f00-3632-495f-8a99-3ad5568024d8"
resource_group_name  = "dev-s4-pce-management"
storage_account_name = "scsdevs4pce"
container_name       = "scs-dev-s4-pce-terraform"
key                  = "test-user/azure-network/terraform.tfstate"
