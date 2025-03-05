/*
  Description: Terraform input variables file
  Comments:
*/

### Terraform Module Variables
root_module      = "s4-pce-cre/azure/EXAMPLE_AZURE_ENVIRONMENT/EXAMPLE0001"
deployment_layer = "integrations/edge-network/layer-00"

### Azure Variables
azure_environment     = "EXAMPLE_AZURE_ENVIRONMENT"
azure_subscription_id = "EXAMPLE_SUBSCRIPTION_ID"
azure_region          = "EXAMPLE_REGION"

### Network Variables
vnet_cidr_block        = "x.x.x.x/21"
vnet_ingress_cidr_list = ["0.0.0.0/0"]

### Networking Variables
subnet_main01_cidr_block  = "x.x.x.x/22"
subnet_gateway_cidr_block = "x.x.x.x/27"

### Legacy Variables
# NOTE: These are for existing deployments with remaining legacy resources - DO NOT USE FOR NEW DEPLOYMENTS
legacy_endpoints = []
