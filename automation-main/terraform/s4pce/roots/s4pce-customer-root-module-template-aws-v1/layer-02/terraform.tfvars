/*
  Description: Terraform input variables
  Comments:
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"

##### VPC Variables

##### Instances
ami_owner_default      = 156506675147
image_database_name    = "Golden-SCS-RHEL-8.6-HANA-V*"
image_application_name = "Golden-SCS-RHEL-8.6-SAPAPP-V*"
// Generate a keypair with `ssh-keygen -b 4096 -m PEM -t rsa -N '' -C EXAMPLE0001 -f ./EXAMPLE0001.pem` .  Store the private key in vault
ssh_main01_public_key = ""

ha_instances = []

##### Default for enabling backup plan
enable_backup = 1 # Set to 0 to disable backup creation


##### Add these values to your local.auto.tfvars
// build_user                                  = ""
// git_name                                    = ""
// git_token                                   = ""


##### Create Additional Backup Bucket
// create_bucket = true

#####  Lifecycle variables
// bucket_retention_days = ""
//  noncurrent_version_expiration = ""
// noncurrent_version_transition_days = ""
