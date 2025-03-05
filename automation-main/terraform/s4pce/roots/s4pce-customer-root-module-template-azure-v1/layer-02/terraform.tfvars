/*
  Description: Terraform input variables file
*/

### Terraform Module Variables
root_module      = "s4-pce-cre/azure/EXAMPLE_AZURE_ENVIRONMENT/EXAMPLE0001"
deployment_layer = "layer-02"

### Azure Variables
azure_environment     = "EXAMPLE_AZURE_ENVIRONMENT"
azure_subscription_id = "EXAMPLE_SUBSCRIPTION_ID"
azure_region          = "EXAMPLE_REGION"

### Image Variables
image_database_name    = "Golden-SCS-RHEL-8.8-HANA-Gen-2-V*"
image_application_name = "Golden-SCS-RHEL-8.8-SAPAPP-V*"

### SAPROUTER Ingress
saprouter_ingress_cidr = ["194.39.131.34/32"]
