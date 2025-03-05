/*
  Description: Terraform input variables
  Comments:
*/

##### AWS Variables
aws_region = "EXAMPLE_STATE_REGION"

##### Mandatory Variables
### Key Pairs
ssh_management_public_key = ""

# backup_metadata = {  selection_name        = "test-short-name" } #optional, use to replace default backup selection name
image_metadata = {
  database_image    = "Golden-SCS-RHEL-8.6-HANA-V*"
  application_image = "Golden-SCS-RHEL-8.6-SAPAPP-V*"
  openvpn_image     = "Golden-SCS-Ubuntu-20.04-Base-V*"
  base_image        = "Golden-SCS-RHEL-8.6-Base-V*"
}

image_owner_default = "156506675147"
