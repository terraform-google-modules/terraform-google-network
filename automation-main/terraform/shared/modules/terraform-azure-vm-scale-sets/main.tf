/*
  Description: Linux Virutal machine scale set without autoscaling.
              For SFTP infra, don't use dynamic scaling as the provisioning is done with Ansible.
              Use manual scaling, with each instance in a seperate zone.
  Comment:
*/

resource "azurerm_linux_virtual_machine_scale_set" "linux_vmss" {
  name                                              = format("%s-%s-scaleset", var.prefix, var.vmscaleset_name)
  resource_group_name                               = var.resource_group_name
  location                                          = var.location
  sku                                               = var.virtual_machine_size
  instances                                         = var.instances_count
  admin_username                                    = var.admin_username
  custom_data                                       = var.custom_data
  overprovision                                     = var.overprovision
  do_not_run_extensions_on_overprovisioned_machines = var.do_not_run_extensions_on_overprovisioned_machines
  encryption_at_host_enabled                        = var.enable_encryption_at_host
  health_probe_id                                   = var.health_probe_id
  platform_fault_domain_count                       = var.platform_fault_domain_count
  provision_vm_agent                                = true
  proximity_placement_group_id                      = null
  scale_in {
    rule                   = "Default"
    force_deletion_enabled = false
  }
  single_placement_group = var.single_placement_group
  //source_image_id                                   = var.source_image_id
  source_image_id = data.azurerm_image.this.id
  upgrade_mode    = var.os_upgrade_mode
  zones           = var.availability_zones
  zone_balance    = var.availability_zone_balance
  tags            = var.tags


  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_key_data
  }

  os_disk {
    storage_account_type      = var.os_disk_storage_account_type
    caching                   = var.os_disk_caching
    disk_encryption_set_id    = var.disk_encryption_set_id
    disk_size_gb              = var.disk_size_gb
    write_accelerator_enabled = var.enable_os_disk_write_accelerator
  }

  dynamic "additional_capabilities" {
    for_each = var.enable_ultra_ssd_data_disk_storage_support ? [1] : []
    content {
      ultra_ssd_enabled = var.enable_ultra_ssd_data_disk_storage_support
    }
  }

  network_interface {
    name = format("%s-%s-vm-nic", lower(replace(var.prefix, "/[[:^alnum:]]/", "")), lower(replace(var.vmscaleset_name, "/[[:^alnum:]]/", "")))

    primary                       = true
    dns_servers                   = var.dns_servers
    enable_ip_forwarding          = var.enable_ip_forwarding
    enable_accelerated_networking = var.enable_accelerated_networking
    network_security_group_id     = var.existing_network_security_group_id

    ip_configuration {
      name      = format("%s-%s-vm-nic-ipconig", lower(replace(var.prefix, "/[[:^alnum:]]/", "")), lower(replace(var.vmscaleset_name, "/[[:^alnum:]]/", "")))
      primary   = true
      subnet_id = var.subnet_id
      #for testing,give the LB a public ip, all VMs should have private ip addresses
      load_balancer_backend_address_pool_ids = var.load_balancer_backend_address_pool_ids
      application_security_group_ids         = var.application_security_group_ids

      dynamic "public_ip_address" {
        for_each = var.assign_public_ip_to_each_vm_in_vmss ? [1] : []
        content {
          name                = format("%s-%s-vm-nic-pip", lower(replace(var.prefix, "/[[:^alnum:]]/", "")), lower(replace(var.vmscaleset_name, "/[[:^alnum:]]/", "")))
          public_ip_prefix_id = var.public_ip_prefix_id
        }
      }
    }
  }

  dynamic "automatic_os_upgrade_policy" {
    for_each = var.os_upgrade_mode == "Automatic" ? [1] : []
    content {
      disable_automatic_rollback  = true
      enable_automatic_os_upgrade = true
    }
  }

  dynamic "rolling_upgrade_policy" {
    for_each = var.os_upgrade_mode != "Manual" ? [1] : []
    content {
      max_batch_instance_percent              = var.rolling_upgrade_policy.max_batch_instance_percent
      max_unhealthy_instance_percent          = var.rolling_upgrade_policy.max_unhealthy_instance_percent
      max_unhealthy_upgraded_instance_percent = var.rolling_upgrade_policy.max_unhealthy_upgraded_instance_percent
      pause_time_between_batches              = var.rolling_upgrade_policy.pause_time_between_batches
    }
  }

  dynamic "automatic_instance_repair" {
    for_each = var.enable_automatic_instance_repair ? [1] : []
    content {
      enabled      = var.enable_automatic_instance_repair
      grace_period = var.grace_period
    }
  }

  lifecycle {
    ignore_changes = [
      automatic_instance_repair,
      automatic_os_upgrade_policy,
      rolling_upgrade_policy,
      instances,
      data_disk,
    ]
  }

  # As per the recomendation by Terraform documentation, an explicit dependency on LB should be used.
  # move this dependency to module level as LB is a seperate module.
}


### Find the latest image to build the instance
data "azurerm_image" "this" {
  resource_group_name = var.image_resource_group_name
  name                = substr(var.search_image_name, -1, -1) == "*" ? null : var.search_image_name
  name_regex          = substr(var.search_image_name, -1, -1) == "*" ? var.search_image_name : null
  sort_descending     = substr(var.search_image_name, -1, -1) == "*" ? true : null
}
