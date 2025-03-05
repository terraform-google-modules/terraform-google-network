/*
  Description: Terraform layer-00 input variables
  Layer: 00
  Comments:
    - Rename this file to terraform.tfvars to use
    - Uncomment and populate the missing variables before use
    - 'vnet_cidr_block' and all associated subnets should have unique CIDR blocks in the account
*/

### Terraform Module Variables
root_module      = "s4-pce-cre/azure/EXAMPLE_AZURE_ENVIRONMENT/EXAMPLE0001"
deployment_layer = "integrations/revese-private-link"

### Azure Variables
azure_environment     = "EXAMPLE_AZURE_ENVIRONMENT"
azure_subscription_id = "EXAMPLE_SUBSCRIPTION_ID"
azure_region          = "EXAMPLE_REGION"

# Set to true to use the Envoy Proxy solution, allowing L7 Proxy with DNS Resolution
enable_proxy = false
image_proxy  = "Golden-SCS-Ubuntu-20.04-Base-V*"
envoy_proxy_values = {
  custom_nameservers = [] # Add the Customer's DNS Resolvers here for Envoy Proxy Solution
  app_keyid          = "0AFCE836BA4D1D35763C8523D8CDC3750181F31F"
  app_repo           = "https://apt.envoyproxy.io"
  app_branch         = "main"
  app_package        = "envoy"
}
# The KeyID was obtained by running: wget -qO- https://apt.envoyproxy.io/signing.key | gpg --with-fingerprint --with-colons | awk -F: '/^fpr/ { print $10 }'
# And verified with the following: gpg --keyserver=keyserver.ubuntu.com --recv-keys <key-id>
