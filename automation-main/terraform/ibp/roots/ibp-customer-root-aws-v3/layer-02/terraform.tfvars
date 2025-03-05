/*
  Description: Terraform input variables
  Comments:
*/

##### AWS Variables
aws_region = "EXAMPLE_REGION"

##### VPC Variables
loadbalancer_cert_fqdn = "EXAMPLE0001.EXAMPLE-FQDN"

##### Instances
image_database_name    = "Golden-SCS-RHEL-8.8-HANA-V*"
image_application_name = "Golden-SCS-RHEL-8.8-SAPAPP-V*"
// Generate a keypair with `ssh-keygen -m PEM -t rsa -N '' -C <customer name> -f ./<output file name>.pem` .  Store the private key in vault
ssh_main01_public_key = ""

# NOTE: Legacy Code was hardcoded to dataservices_1.  Maintaining the selection for backwards compatibility only.
cpids_lb_subnets = ["dataservices_1", "dataservices_2"]


##### Add these values to your local.auto.tfvars
// build_user                                  = ""
// git_name                                    = ""
// git_token                                   = ""

# THe following are DEPRECATED, use instance.auto.tfvars instead.
# instance_webdispatcher_cnames = []
# instance_customer_number_cname_prefix = "EXAMPLE_CNAME_PREFIX"
