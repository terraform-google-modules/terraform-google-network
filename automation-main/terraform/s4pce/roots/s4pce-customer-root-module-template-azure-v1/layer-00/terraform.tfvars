/*
  Description: Terraform input variables file
  NOTE: Louis 2025-02-20 - Should move the region specific option to layer-options.
*/

### Terraform Module Variables
root_module      = "s4-pce-cre/azure/EXAMPLE_AZURE_ENVIRONMENT/EXAMPLE0001"
deployment_layer = "layer-00"

### Azure Variables
azure_environment     = "EXAMPLE_AZURE_ENVIRONMENT"
azure_subscription_id = "EXAMPLE_SUBSCRIPTION_ID"
azure_region          = "EXAMPLE_REGION"

### Naming and Tagging Variables
label_order = [
  "security_boundary",
  "business",
  "business_subsection",
  "customer"
]
organization = {
  name     = "EXAMPLE_ORGANIZATION", formatted = "EXAMPLE_ORGANIZATION"
  friendly = "EXAMPLE_ORGANIZATION_FRIENDLY_NAME"
}
security_boundary = {
  name     = "EXAMPLE_SECURITY_BOUNDARY", formatted = "EXAMPLE_SECURITY_BOUNDARY"
  friendly = "EXAMPLE_SECURITY_BOUNDARY_FRIENDLY_NAME"
}
business = {
  name     = "s4", formatted = "S4"
  friendly = "S4 Hana"
}
business_subsection = {
  name     = "pce", formatted = "PCE"
  friendly = "Private Cloud Edition"
}
customer = {
  name      = "EXAMPLE0001", single_tenant = true,
  formatted = "EXAMPLE0001", friendly = "EXAMPLE0001"
}
cloud_provider = {
  name     = "azure", formatted = "Azure"
  friendly = "Azure"
}
cloud_partition = {
  name     = "EXAMPLE_CLOUD", formatted = "EXAMPLE_CLOUD_PARTITION_FRIENDLY_NAME"
  friendly = "EXAMPLE_CLOUD_PARTITION_FRIENDLY_NAME"
}
owner       = "EXAMPLE_OWNER_EMAIL"
environment = "EXAMPLE_ENVIRONMENT"

### Network Variables
vnet_cidr_block = "EXAMPLE_10.0.0.0/21"
vnet_subnets = {
  production        = { cidr = "EXAMPLE_10.0.0.0/23", zone = "1" }
  development       = { cidr = "EXAMPLE_10.0.2.0/23", zone = "3" }
  quality-assurance = { cidr = "EXAMPLE_10.0.4.0/24", zone = "2" }
  sandbox           = { cidr = "EXAMPLE_10.0.5.0/24", zone = "3" }
  edge              = { cidr = "EXAMPLE_10.0.6.0/23", zone = null }
}

### Key Pairs
ssh_customer_public_key = ""

### Golden AMI Variables
golden_image_resource_group = "EXAMPLE_IMAGE_RESOURCE_GROUP_NAME"

### /usr/sap/trans upsize to (new size in GB)
# nfs_storage_quota = ###


# Allow AD group 'sg_s4_pce_azure_operations' to create Vnet Gateway or not.
# this is added to handle customers like customer007
# NOTE: This looks like a region specific customization. Should move it to Layer-Options.
vnet_gateway_permissions_enable = false

# update to "No-Zone" only if target region doesn't support AZ
lb_front_end_ip_zones = "Zone-Redundant"
