azure-endpoint-services-multiport Module
========================================

This module creates an Azure Private Link Endpoint on demand.

**Table of Contents:**

[[_TOC_]]

Dependencies
------------

* Terraform 0.14+
* Azure priviledges to manage the necessary services

Module Variables
----------------

| Variable Name | Default | Description | Value Options |
| ------------- | ------- | ----------- | ------------- |
| location | | (**Required**) The location/region where the LB will be created | |
| resource_group_name | | (**Required**) The name of the resource group for the load balancer | |
| remote_port | | (**Optional**)  Protocols to be used for remote vm access -- only if this feature is needed| |
| loadbalancer_probe_unhealthy_threshold | | (**Optional**) Number of times the load balancer health probe has an unsuccessful attempt before considering the endpoint unhealthy | default - 5|
| loadbalancer_enable_floating_ip | | (**Optional**) Enable floating ip for load balancer or not | default - 'false'|
| loadbalancer_probe_interval | | (**Required**) Interval in seconds the load balancer health probe rule does a check | default 5 |
| loadbalancer_idle_timeout_in_minutes | | (**Required**) idle timeout in mins | default 5 |
| pip_allocation_method | | (**Optional**) Defines how public IP address is assigned. Options are Static or Dynamic - only used if LB type is 'public' | |
| loadbalancer_type | | (**Required**) Defined if the loadbalancer is private or public | default 'private' |
| loadbalancer_subnet_id | | (**Required**)  LB subnet id to use when in private mode | |
| loadbalancer_frontend_private_ip_address_allocation | | (**Required**) Frontend ip allocation type (Static or Dynamic | default Dynamic|
| loadbalancer_sku | | (**Required**) The SKU of the Azure Load Balancer. Accepted values are Basic and Standard. | default Standard|
| loadbalancer_probe | | (**Required**) Protocols to be used for lb health probes. Format as map of [protocol, port, request_path] | |
| pip_sku | | (**Optional**)  The SKU of Azure public ip. Accepted values are Basic and Standard. Only required if LB is public | default Standard|
| loadbalancer_port | | (**Required**) Protocols to be used for lb rules. Format as [frontend_port, protocol, backend_port,backend_pool_name,loadbalancer_frontendip_private_link_map key] | |
| loadbalancer_frontendip_private_link_map | | (**Required**)  A map with loadbalancer_frontend_ip_name/private_link_service_name/private_endpoint_name. | |
| frontend_private_ip_addresses | | (**Optional**) private ip addresses to assign to frontend. Use it with type = private and address allocation is static. | |
| loadbalancer_backend_pool_names | | (**Required**) list of names of LB backend pools | |
| enable_domain_name | | (**Optional**)  whether to use domain name or not | default false|
| domain_name_labels | | (**Required**) domain name label. This is only needed if we use public IPs/Azure domain names | |
| private_link_endpoint_subnet_id | | (**Required**) Subnet id for the Private Endpoint | |
| private_link_service_subnet_id | | (**Required**) Subnet id for the Private Link Service | |


Sample usage:

```
module "lb" {
  source = "../"

  resource_group_name             = local.resource_group_name
  location                        = module.network.lb_vnet_location
  loadbalancer_subnet_id                    = module.network.lb_vnet_subnets[0]
  private_link_endpoint_subnet_id = module.network.ple_vnet_subnets[0]
  private_link_service_subnet_id  = module.network.lb_vnet_subnets[1]


  loadbalancer_name                    = "azure-lb"

  loadbalancer_frontendip_private_link_map = {
    service1 = {
    loadbalancer_frontend_ip_name = "frontip1"
    private_link_service_name    = "private-link-service-1"
    private_endpoint_name         = "private-link-endpoint-1"
    },
    service2 = {
    loadbalancer_frontend_ip_name = "frontip2"
    private_link_service_name    = "private-link-service-2"
    private_endpoint_name         = "private-link-endpoint-2"
    },
    service3 = {
    loadbalancer_frontend_ip_name = "frontip3"
    private_link_service_name    = "private-link-service-3"
    private_endpoint_name         = "private-link-endpoint-3"
    },
  }

  loadbalancer_backend_pool_names = ["pool1", "pool2"]

  loadbalancer_port = {
    https1-rule = ["1443", "Tcp", "6443", "pool1", "service1"]
    https2-rule = ["443", "Tcp", "443", "pool1", "service2"]
    https3-rule = ["2443", "Tcp", "8443", "pool2", "service3"]
  }
  loadbalancer_probe = {
    https1-probe = ["Tcp", "6443", ""]
    https2-probe = ["Tcp", "443", ""]
    https3-probe = ["Tcp", "8443", ""]
  }

}
```

Author Information
------------------

* Jian Ouyang (jian.ouyang@sapns2.com)
* Devon Thyne (devon.thyne@sapns2.com)
* Louis Lee (louis.lee@sapns2.com)
