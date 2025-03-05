/*
  Description: Core module configurations; Core data resources, base context, global local variables, etc
  Comments:
    - Calls module s4pce_customer_infrastructure_azure for infrastructure creation
*/

### Core Data Resources
data "azurerm_subscription" "current" {}

### Context
module "base_context" {
  source = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"

  account_id             = data.azurerm_subscription.current.id
  build_user             = var.build_user
  business               = var.business.name
  customer               = var.customer.name
  include_customer_label = var.customer.single_tenant
  environment            = var.environment
  organization           = var.organization.name
  label_order            = var.label_order
  owner                  = var.owner
  partition              = var.azure_environment
  region                 = var.azure_region
  root_module            = var.root_module
  security_boundary      = var.security_boundary.name

  environment_values = {
    kv = {
      organization_formatted                = var.organization.formatted
      organization_friendly_name            = var.organization.friendly
      security_boundary_formatted           = var.security_boundary.formatted
      security_boundary_friendly_name       = var.security_boundary.friendly
      business_formatted                    = var.business.formatted
      business_friendly_name                = var.business.friendly
      cloud_provider                        = var.cloud_provider.name
      cloud_provider_formatted              = var.cloud_provider.formatted
      cloud_provider_friendly_name          = var.cloud_provider.friendly
      cloud_partition                       = var.cloud_partition.name
      cloud_partition_formatted             = var.cloud_partition.formatted
      cloud_partition_friendly_name         = var.cloud_partition.friendly
      minor_security_boundary               = var.minor_security_boundary.name
      minor_security_boundary_formatted     = var.minor_security_boundary.formatted
      minor_security_boundary_friendly_name = var.minor_security_boundary.friendly
      business_subsection                   = var.business_subsection.name
      business_subsection_formatted         = var.business_subsection.formatted
      business_subsection_friendly_name     = var.business_subsection.friendly
      account_identifier                    = var.account_identifier.name
      account_identifier_formatted          = var.account_identifier.formatted
      account_identifier_friendly_name      = var.account_identifier.friendly
      customer_formatted                    = var.customer.formatted
      customer_friendly_name                = var.customer.friendly
      prefix_friendly_name                  = "${var.security_boundary.friendly} ${var.business.friendly} ${var.customer.name}"
    }
    tags = [
      { name = "MinorSecurityBoundary", value = "minor_security_boundary", required = false },
      { name = "BusinessSubsection", value = "business_subsection", required = false },
      { name = "AccountIdentifier", value = "account_identifier", required = false },
    ]
    locals = null
  }
}

module "layer_context" {
  source  = "EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context = module.base_context.context

  environment_values = {
    kv = {
      deployment_layer = var.deployment_layer
    }
    tags   = null
    locals = null
  }
}

### Global Local Variables
locals {
  unique_zones = sort(distinct([
    for key, value in var.vnet_subnets : value.zone if(value.zone != null)
  ]))

  az_letter_mapping = {
    for key in local.unique_zones : "az${key}" => key
  }
}

### Infrastructure (VNet, subnets, security groups etc.)
module "s4pce_customer_infrastructure" {
  source = "EXAMPLE_SOURCE/terraform/s4pce/modules/s4pce-customer-infrastructure-azure"

  context                                         = module.layer_context.context
  vnet_cidr_block                                 = var.vnet_cidr_block
  vnet_subnets                                    = var.vnet_subnets
  dns_zone                                        = lookup(local.management_layer_00, "dns_zone_management_internal", { fqdn = null }).fqdn
  vnet_gateway_permissions_enable                 = var.vnet_gateway_permissions_enable
  nfs_storage_quota                               = var.nfs_storage_quota
  tier_to_cool_days                               = var.tier_to_cool_days
  tier_to_archive_days                            = var.tier_to_archive_days
  delete_after_days                               = var.delete_after_days
  adv_min_tls_version                             = var.adv_min_tls_version
  adv_allow_nested_items_to_be_public             = var.adv_allow_nested_items_to_be_public
  adv_subnet_endpoint_network_policies            = var.adv_subnet_endpoint_network_policies
  adv_subnet_service_network_policies             = var.adv_subnet_service_network_policies
  adv_storage_account_https_only_customer_backups = var.adv_storage_account_https_only_customer_backups
  adv_storage_account_https_only_customer_nfs     = var.adv_storage_account_https_only_customer_nfs
}
