/*
  Description: Terraform variables for initialization; The variables contained in this page will be used to initialize this terraform module.
  Comments:
    - https://developer.hashicorp.com/terraform/language/settings/backends/azurerm#configuration-variables
    - Substitute the variables with the correct values.
    - Initialize with the following command. terraform init -backend-config=backend.tfvars
*/

##### Terraform iam-role backend configuration
environment          = "public"
subscription_id      = "abcdef-12345"
resource_group_name  = "RESOURCE_GROUP_NAME"
storage_account_name = "STORAGE_ACCOUNT_NAME"
container_name       = "CONTAINER_NAME"
key                  = "KEY_PATH/terraform.tfstate"
