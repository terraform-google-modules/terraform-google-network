Terraform Azure Storage Account Network Rules Subnet
====================================================

Maintains a permitted subnet within the Network Rules for an Azure Storage Account. Developed to get around the lack of support for a Terraform resource that can maintain this outside initial network rules creation.

**Table of Contents:**

[[_TOC_]]

Requirements
------------

* Terraform v0.13+
* Azure `az` CLI
* `jq`

Example Usage
-------------

```hcl
resource "azurerm_storage_account" "example_nfs" {
  resource_group_name       = "example-rg"
  location                  = "eastus"
  name                      = "examplenfs"
  account_kind              = "FileStorage"
  account_tier              = "Premium"
  account_replication_type  = "LRS"
  enable_https_traffic_only = false
}

locals {
  subnets = [
    "/subscriptions/XXX/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/test1"
    "/subscriptions/XXX/resourceGroups/example-rg/providers/Microsoft.Network/virtualNetworks/example-vnet/subnets/test2"
  ]
}

module "azurerm_storage_account_network_rules_subnets" {
  source   = "<path>/<to>/ns2-terraform/modules/terraform-azure-storage-account-network-rules-subnet"
  for_each = toset(local.subnets)

  resource_group       = "example-rg"
  storage_account_name = azurerm_storage_account.example_nfs.name
  subnet_id            = each.key
}
```

Argument Reference
------------------

* `resource_group` - (`<string>`) Name of the Resource Group that the Storage Account belongs to
* `storage_account_name` - (`<string>`) Name of the Storage Account to manage subnet network-rules for
* `subnet_id` - (`<string>`) Subnet ID to enforce Store Account network rule for, will not enforce destructively to existing subnet network-rules already present

Author Information
------------------

* Devon Thyne [devon.thyne@sapns2.com](mailto:devon.thyne@sapns2.com)
