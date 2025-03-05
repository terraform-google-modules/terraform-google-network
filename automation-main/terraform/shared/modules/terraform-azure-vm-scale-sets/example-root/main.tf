/*
  Description: construct a LB and a VM Scaleset.
  Comment:
*/
locals {
  resource_group_name = "sftp-rg"
}

#create resource group and network
module "network" {
  source = ".//preliminary-modules/test-networks"

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
  az_location = "eastus"
  #azure government
  //z_location = "usgovvirginia"
}

module "base_context" {
  source            = "../../../modules/terraform-null-context/modules/legacy"
  account_id        = "accountid"
  build_user        = var.build_user
  business          = "s4"
  customer          = "ns2"
  environment       = "test"
  name_prefix       = "test"
  organization      = "ns2"
  owner             = var.build_user
  root_module       = null
  security_boundary = "ns2"
  partition         = "any"
  region            = "anywhere"
}

#create LB, private services and links
module "lb" {
  source = "../../azure-endpoint-services-multiport"

  resource_group_name             = local.resource_group_name
  location                        = module.network.lb_vnet_location
  loadbalancer_subnet_id          = module.network.lb_vnet_subnets[0]
  private_link_endpoint_subnet_id = module.network.private_link_endpoint_vnet_subnets[0]
  private_link_service_subnet_id  = module.network.lb_vnet_subnets[1]

  context           = module.base_context.context
  loadbalancer_name = "${module.base_context.resource_prefix}-lb"
  loadbalancer_frontendip_private_link_map = {
    sftp_service = {
      loadbalancer_frontend_ip_name = "sftp_ip"
      private_link_service_name     = "sftp-private-link-service"
      private_endpoint_name         = "sftp-private-link-endpoint"
    },
  }
  loadbalancer_backend_pool_names = ["sftp-pool"]

  loadbalancer_port = {
    sftp-rule = ["8022", "Tcp", "8022", "sftp-pool", "sftp_service"]
  }
  loadbalancer_probe = {
    sftp-probe = ["Tcp", "8022", ""]
  }
}

module "sftp_pool" {
  source              = "../"
  prefix              = module.base_context.resource_prefix
  resource_group_name = local.resource_group_name
  location            = module.network.lb_vnet_location

  image_resource_group_name = "build-images-eastus-592b5c737eea"
  search_image_name         = "Golden-NS2-RHEL-8.5-Base-V*"

  vnet_id                            = module.network.lb_vnet_id
  subnet_id                          = module.network.lb_vnet_subnets[0]
  vnet_resource_group_name           = local.resource_group_name
  existing_network_security_group_id = azurerm_network_security_group.nsg.id
  vmscaleset_name                    = "sftp"
  virtual_machine_size               = "Standard_D2s_v3"
  admin_username                     = "cloud-user"
  instances_count                    = 3
  disk_size_gb                       = 100
  availability_zones                 = [1, 2, 3]
  //use the first backend_pool and health probe from LB moduel
  health_probe_id                        = module.lb.azurerm_loadbalancer_probe_ids[0]
  load_balancer_backend_address_pool_ids = module.lb.azurerm_lb_backend_address_pool_ids

  tags               = module.base_context.tags
  admin_ssh_key_data = tls_private_key.testkey.public_key_openssh
  #need public ip for test only: ansible sftp provisioning
  assign_public_ip_to_each_vm_in_vmss = true
  #need to have this, implicit dependency not working
  depends_on = [module.lb]
}
