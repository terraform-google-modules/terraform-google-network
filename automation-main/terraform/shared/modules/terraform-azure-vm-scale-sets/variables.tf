/*
  Description: module varialbes/inputs.
  Comment:
*/
variable "resource_group_name" {
  description = "resource group name"
  type        = string
}

variable "location" {
  description = "The location/region where the resource will be created."
  type        = string
}

variable "vnet_resource_group_name" {
  description = "vnet resource group name"
  type        = string
}

variable "vnet_id" {
  description = "The id of the virtual network"
  type        = string
}

variable "subnet_id" {
  description = "The name of the subnet to use in VM scale set"
  type        = string
}

variable "prefix" {
  description = "prefix for all resources in this module"
  type        = string
  default     = "sftp"
}

variable "vmscaleset_name" {
  description = "The prefix which should be used for the name of the Virtual Machines in this Scale Set. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name_prefix, then you must specify computer_name_prefix"
  default     = ""
}

variable "virtual_machine_size" {
  description = "The Virtual Machine SKU for the Scale Set, Default is Standard_A2_V2"
  default     = "Standard_A2_v2"
}

variable "instances_count" {
  description = "The number of Virtual Machines in the Scale Set."
  default     = 3
}

variable "admin_username" {
  description = "The username of the local administrator used for the Virtual Machine."
  default     = "rancher"
}

variable "custom_data" {
  description = "The Base64-Encoded Custom Data which should be used for this Virtual Machine Scale Set."
  default     = null
}


variable "overprovision" {
  description = "Should Azure over-provision Virtual Machines in this Scale Set? This means that multiple Virtual Machines will be provisioned and Azure will keep the instances which become available first - which improves provisioning success rates and improves deployment time. You're not billed for these over-provisioned VM's and they don't count towards the Subscription Quota. Defaults to true."
  default     = false
}

variable "enable_encryption_at_host" {
  description = " Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  default     = false
}


variable "platform_fault_domain_count" {
  description = "Specifies the number of fault domains that are used by this Linux Virtual Machine Scale Set."
  default     = 5
}


variable "single_placement_group" {
  description = "Allow to have cluster of 100 VMs only"
  default     = true
}

variable "os_upgrade_mode" {
  description = "Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Automatic"
  default     = "Manual"
}

variable "availability_zones" {
  description = "A list of Availability Zones in which the Virtual Machines in this Scale Set should be created in"
  default     = [1, 2, 3]
}

variable "availability_zone_balance" {
  description = "Should the Virtual Machines in this Scale Set be strictly evenly distributed across Availability Zones?"
  default     = false
}

variable "admin_ssh_key_data" {
  description = "specify existing ssh key to authenciate linux vm"
  default     = null
}

variable "load_balancer_backend_address_pool_ids" {
  description = "load_balancer_backend_address_pool_ids for scaleset"
  default     = null
}

variable "existing_network_security_group_id" {
  description = "nsg for scaleset"
  default     = null
}
variable "health_probe_id" {
  description = "health probe id for scaleset"
  default     = null
}

#name is from AzureRM, "do_not" is misleading
variable "do_not_run_extensions_on_overprovisioned_machines" {
  description = "Should Virtual Machine Extensions be run on Overprovisioned Virtual Machines in the Scale Set?"
  default     = false
}

variable "os_disk_storage_account_type" {
  description = "The Type of Storage Account which should back this the Internal OS Disk. Possible values include `Standard_LRS`, `StandardSSD_LRS` and `Premium_LRS`."
  default     = "StandardSSD_LRS"
}

variable "os_disk_caching" {
  description = "The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`"
  default     = "ReadWrite"
}

variable "disk_encryption_set_id" {
  description = "The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. The Disk Encryption Set must have the `Reader` Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault"
  default     = null
}

variable "disk_size_gb" {
  description = "The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Scale Set is sourced from."
  default     = 100
}

variable "enable_os_disk_write_accelerator" {
  description = "Should Write Accelerator be Enabled for this OS Disk? This requires that the `storage_account_type` is set to `Premium_LRS` and that `caching` is set to `None`."
  default     = false
}

variable "enable_ultra_ssd_data_disk_storage_support" {
  description = "Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine"
  default     = false
}

variable "additional_data_disks" {
  description = "Adding additional disks capacity to add each instance (GB)"
  type        = list(number)
  default     = []
}

variable "additional_data_disks_storage_account_type" {
  description = "The Type of Storage Account which should back this Data Disk. Possible values include Standard_LRS, StandardSSD_LRS, Premium_LRS and UltraSSD_LRS."
  default     = "Standard_LRS"
}

variable "dns_servers" {
  description = "List of dns servers to use for network interface"
  default     = []
}

variable "enable_ip_forwarding" {
  description = "Should IP Forwarding be enabled? Defaults to false"
  default     = false
}

variable "enable_accelerated_networking" {
  description = "Should Accelerated Networking be enabled? Defaults to false."
  default     = false
}

variable "assign_public_ip_to_each_vm_in_vmss" {
  description = "Create a virtual machine scale set that assigns a public IP address to each VM"
  default     = false
}

variable "public_ip_prefix_id" {
  description = "The ID of the Public IP Address Prefix from where Public IP Addresses should be allocated"
  default     = null
}

variable "rolling_upgrade_policy" {
  description = "Enabling automatic OS image upgrades on your scale set helps ease update management by safely and automatically upgrading the OS disk for all instances in the scale set."
  type = object({
    max_batch_instance_percent              = number
    max_unhealthy_instance_percent          = number
    max_unhealthy_upgraded_instance_percent = number
    pause_time_between_batches              = string
  })
  default = {
    max_batch_instance_percent              = 20
    max_unhealthy_instance_percent          = 20
    max_unhealthy_upgraded_instance_percent = 20
    pause_time_between_batches              = "PT0S"
  }
}

variable "enable_automatic_instance_repair" {
  description = "Should the automatic instance repair be enabled on this Virtual Machine Scale Set?"
  default     = false
}

variable "grace_period" {
  description = "Amount of time (in minutes, between 30 and 90, defaults to 30 minutes) for which automatic repairs will be delayed."
  default     = "PT30M"
}

variable "managed_identity_type" {
  description = "The type of Managed Identity which should be assigned to the Linux Virtual Machine Scale Set. Possible values are `SystemAssigned`, `UserAssigned` and `SystemAssigned, UserAssigned`"
  default     = null
}

variable "managed_identity_ids" {
  description = " A list of User Managed Identity ID's which should be assigned to the Linux Virtual Machine Scale Set."
  default     = null
}


variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

##### Image Variables
variable "search_image_name" {
  description = "The expression to look for the image that the virtual machine will use"
  type        = string
}
variable "image_resource_group_name" {
  description = "Name of the Resource Group in which the Linux Virtual Machine Image exists"
  type        = string
}

variable "application_security_group_ids" {
  description = "A list of application secrurity group ids"
  default     = []
}
