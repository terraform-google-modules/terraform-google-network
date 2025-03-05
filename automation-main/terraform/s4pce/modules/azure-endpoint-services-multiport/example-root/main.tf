locals {
  resource_group_name = "lb-private-link-rg"
}

#create resource group and network
module "network" {
  source = ".//preliminary-modules/azure-network"

  resource_group_name = local.resource_group_name
  vnet_name           = "loadbalancer-vnet"
  address_space       = "172.30.0.0/16"
  subnet_prefixes     = ["172.30.0.0/24", "172.30.1.0/24"]
  subnet_names        = ["loadbalancer-subnet", "private-link-service-snet"]

  vnet_name2       = "private-link-vnet"
  address_space2   = "172.32.0.0/16"
  subnet_prefixes2 = ["172.32.0.0/24"]
  subnet_names2    = ["private-link-endpoint-snet"]
  #use the following for azure commerical
  //az_location = "eastus"
  #azure government
  az_location = "usgovvirginia"
}

module "base_context" {
  source            = "../../../../shared/modules/terraform-null-context/modules/legacy"
  account_id        = "accountid"
  build_user        = var.build_user
  business          = "scs"
  customer          = "scs"
  environment       = "test"
  name_prefix       = "test"
  organization      = "scs"
  owner             = var.build_user
  root_module       = null
  security_boundary = "scs"
  partition         = "any"
  region            = "anywhere"
}


#create LB, private services and links
module "lb" {
  source = "../"

  resource_group_name             = local.resource_group_name
  location                        = module.network.lb_vnet_location
  loadbalancer_subnet_id          = module.network.lb_vnet_subnets[0]
  private_link_endpoint_subnet_id = module.network.private_link_endpoint_vnet_subnets[0]
  private_link_service_subnet_id  = module.network.lb_vnet_subnets[1]
  front_end_ip_zones              = ["1"]

  context           = module.base_context.context
  loadbalancer_name = module.base_context.resource_prefix
  loadbalancer_frontendip_private_link_map = {
    service1 = {
      loadbalancer_frontend_ip_name = "frontip1"
      private_link_service_name     = "private-link-service-1"
      private_endpoint_name         = "private-link-endpoint-1"
    },
    service2 = {
      loadbalancer_frontend_ip_name = "frontip2"
      private_link_service_name     = "private-link-service-2"
      private_endpoint_name         = "private-link-endpoint-2"
    },
    service3 = {
      loadbalancer_frontend_ip_name = "frontip3"
      private_link_service_name     = "private-link-service-3"
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
