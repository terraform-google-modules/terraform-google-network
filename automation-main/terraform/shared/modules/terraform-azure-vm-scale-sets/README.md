azure-vm-scale-sets Module
==================================

This module creates a linux vm scaleset for SFTP.

NOTE: This module currently is applied out of order for the SPR workflow.  This should be addressed in milestone 2 of the Interface-SFTP Epic: BUILDSTE-2023

In the interim.  The scaleset should be generated using terraform and the outputs should be inserted back into the inventory for application provisioning.  Certain values in the inventory will be unused such as `spr_size`


**Table of Contents:**

[[_TOC_]]

Module Order of Operations
--------------------------
To make terraform run in a specific order, use the `module_dependency` variable in `main.tf` calling block to pass the output of another module to create a dependency.  Leave this variable blank to run immediately.

Dependencies
------------

* Terraform 1.0.4+
* Azure priviledges to manage the necessary services


Module Variables
---------------------------

| Variable Name                        | Default    | Description |
| ------------------------------------ | ---------- | ----------- |
| name_prefix | name prefix for all resources | `string` || no |
| resource_group_name | Resource Group for all to-be-created resources" | `string` || no |
|(refer to variables.tf for other variables)


### Examples:

The below example shows how to use this module.

```
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

#create VM scaleset and associate it with the previously created LB
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
```

Author Information
------------------

* Jian Ouyang (jian.ouyang@sapns2.com)
