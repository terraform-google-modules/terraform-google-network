/*
  Description:
    Create Load Balancer with multiple frontend ips and multiple backend pools.
*/

locals {
  //construct a list of loadbalancer_frontend_ip_names
  loadbalancer_frontend_ip_names = [for e in var.loadbalancer_frontendip_private_link_map : e.loadbalancer_frontend_ip_name]
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.loadbalancer_type == "public" ? length(local.loadbalancer_frontend_ip_names) : 0
  name                = "${var.loadbalancer_name}-pip-${local.loadbalancer_frontend_ip_names[count.index]}"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.pip_allocation_method
  sku                 = var.pip_sku
  tags                = module.base_layer_context.tags

  domain_name_label = var.enable_domain_name ? var.loadbalancer_type == "public" ? var.domain_name_labels[count.index] : "" : ""
}

resource "azurerm_lb" "loadbalancer" {
  name                = var.loadbalancer_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.loadbalancer_sku
  tags = merge(module.base_layer_context.tags, {
    Name        = var.loadbalancer_name
    Description = title(replace(var.loadbalancer_name, "-", " "))
  })

  dynamic "frontend_ip_configuration" {

    for_each = [for n in local.loadbalancer_frontend_ip_names : { name = n }]

    content {
      name = "${frontend_ip_configuration.value.name}-ip-config"

      public_ip_address_id          = var.loadbalancer_type == "public" ? azurerm_public_ip.public_ip.*.id[index(local.loadbalancer_frontend_ip_names, frontend_ip_configuration.value.name)] : null
      subnet_id                     = var.loadbalancer_type == "public" ? "" : var.loadbalancer_subnet_id
      private_ip_address_allocation = var.loadbalancer_frontend_private_ip_address_allocation
      private_ip_address            = var.loadbalancer_frontend_private_ip_address_allocation == "Dynamic" ? "" : var.frontend_private_ip_addresses[index(local.loadbalancer_frontend_ip_names, frontend_ip_configuration.value.name)]
      zones                         = var.adv_lb_no_zone ? null : var.front_end_ip_zones
    }
  }
}

resource "azurerm_lb_backend_address_pool" "backend_address_pool" {
  count           = length(var.loadbalancer_backend_pool_names)
  name            = var.loadbalancer_backend_pool_names[count.index]
  loadbalancer_id = azurerm_lb.loadbalancer.id
}

resource "azurerm_lb_nat_rule" "nat_rule" {
  count               = var.loadbalancer_type == "public" ? length(var.remote_port) : 0
  name                = "nat-${count.index}"
  resource_group_name = var.resource_group_name

  loadbalancer_id                = azurerm_lb.loadbalancer.id
  protocol                       = element(var.remote_port[element(keys(var.remote_port), count.index)], 0)
  frontend_port                  = "6000${count.index + 1}"
  backend_port                   = element(var.remote_port[element(keys(var.remote_port), count.index)], 1)
  frontend_ip_configuration_name = "${local.loadbalancer_frontend_ip_names[index(local.loadbalancer_frontend_ip_names, element(var.remote_port[element(keys(var.remote_port), count.index)], 2))]}-ip-config"
}

resource "azurerm_lb_probe" "probe" {
  count           = length(var.loadbalancer_probe)
  name            = element(keys(var.loadbalancer_probe), count.index)
  loadbalancer_id = azurerm_lb.loadbalancer.id

  protocol            = element(var.loadbalancer_probe[element(keys(var.loadbalancer_probe), count.index)], 0)
  port                = element(var.loadbalancer_probe[element(keys(var.loadbalancer_probe), count.index)], 1)
  interval_in_seconds = var.loadbalancer_probe_interval
  number_of_probes    = var.loadbalancer_probe_unhealthy_threshold
  request_path        = element(var.loadbalancer_probe[element(keys(var.loadbalancer_probe), count.index)], 2)
}

resource "azurerm_lb_rule" "rules" {
  count           = length(var.loadbalancer_port)
  name            = element(keys(var.loadbalancer_port), count.index)
  loadbalancer_id = azurerm_lb.loadbalancer.id
  protocol        = element(var.loadbalancer_port[element(keys(var.loadbalancer_port), count.index)], 1)
  frontend_port   = element(var.loadbalancer_port[element(keys(var.loadbalancer_port), count.index)], 0)
  backend_port    = element(var.loadbalancer_port[element(keys(var.loadbalancer_port), count.index)], 2)
  #current implementation using map key to retrieve front_end_ip config name
  frontend_ip_configuration_name = format("%s%s", var.loadbalancer_frontendip_private_link_map[element(var.loadbalancer_port[element(keys(var.loadbalancer_port), count.index)], 4)].loadbalancer_frontend_ip_name, "-ip-config")
  #we can also use the frontend ip config name directly
  //frontend_ip_configuration_name = format("%s%s", element(var.loadbalancer_port[element(keys(var.loadbalancer_port), count.index)], 4), "-ip-config")
  enable_floating_ip       = var.loadbalancer_enable_floating_ip
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.backend_address_pool.*.id[index(var.loadbalancer_backend_pool_names, element(var.loadbalancer_port[element(keys(var.loadbalancer_port), count.index)], 3))]]
  idle_timeout_in_minutes  = var.loadbalancer_idle_timeout_in_minutes
  probe_id                 = element(azurerm_lb_probe.probe.*.id, count.index)
}
