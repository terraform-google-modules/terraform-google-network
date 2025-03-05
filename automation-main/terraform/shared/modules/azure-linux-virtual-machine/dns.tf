/*
    Description: Creates DNS Zone records associated with the Virtual Machine
    Input Triggers:
      - dns_associate_private_ip_address: Boolean value, a value of true will trigger this file.
*/

data "azurerm_private_dns_zone" "instance" {
  count = (var.dns_associate_private_ip_address && var.dns_zone != "") ? 1 : 0
  name  = var.dns_zone
}

resource "azurerm_private_dns_a_record" "instance" {
  count = var.dns_associate_private_ip_address == true ? 1 : 0

  resource_group_name = var.resource_group_name
  name                = azurerm_linux_virtual_machine.instance.virtual_machine_id
  zone_name           = data.azurerm_private_dns_zone.instance[0].name
  ttl                 = var.dns_ttl
  records             = azurerm_linux_virtual_machine.instance.private_ip_addresses
}

locals {
  tag_productname          = lookup(azurerm_linux_virtual_machine.instance.tags, "ProductName", "")
  tag_productcluster       = lookup(azurerm_linux_virtual_machine.instance.tags, "ProductCluster", "")
  tag_productcomponent     = lookup(azurerm_linux_virtual_machine.instance.tags, "ProductComponent", "")
  instance_cname_simple    = "${local.tag_productname}-${azurerm_linux_virtual_machine.instance.virtual_machine_id}"
  instance_cname_cluster   = local.tag_productcluster != "" ? "${local.tag_productcluster}-${local.instance_cname_simple}" : ""
  instance_cname_component = local.tag_productcomponent != "" ? "${local.tag_productcomponent}-${local.instance_cname_simple}" : ""
  instance_cname_both      = local.tag_productcluster != "" && local.tag_productcomponent != "" ? "${local.tag_productcomponent}-${local.tag_productcluster}-${local.instance_cname_simple}" : ""
  instance_cname           = local.instance_cname_both != "" ? local.instance_cname_both : (local.instance_cname_component != "" ? local.instance_cname_component : (local.instance_cname_cluster != "" ? local.instance_cname_cluster : local.instance_cname_simple))
}

resource "azurerm_private_dns_cname_record" "instance" {
  count = ((var.dns_associate_private_ip_address == true) && (var.dns_associate_cname == true)) ? 1 : 0

  resource_group_name = var.resource_group_name
  name                = lower(local.instance_cname)
  zone_name           = data.azurerm_private_dns_zone.instance[0].name
  ttl                 = var.dns_ttl
  record              = azurerm_private_dns_a_record.instance[0].fqdn
}

resource "azurerm_private_dns_cname_record" "instance_additional" {
  for_each = (var.dns_associate_private_ip_address == true) ? toset(var.dns_additional_cnames) : toset([])

  resource_group_name = var.resource_group_name
  name                = each.key
  zone_name           = data.azurerm_private_dns_zone.instance[0].name
  ttl                 = var.dns_ttl
  record              = azurerm_private_dns_a_record.instance[0].fqdn
}
