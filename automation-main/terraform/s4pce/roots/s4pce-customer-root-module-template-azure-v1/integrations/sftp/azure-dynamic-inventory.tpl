---
# Synopsis: CRE-S4PCE ${customer_name} SFTP Inventory
# Inputs: N/A
# Outputs: N/A
# Comments:
plugin: azure_rm
auth_source: auto  #auto, cli, credential_file, env,msi
batch_fetch: yes

# fetches VMs from an explicit list of resource groups instead of default all (- '*')
# the following can be removed with exclude_host_filters, it just take longer to get the host list
include_vm_resource_groups:
- NetworkWatcherRG  #don't want to have any VMs, this rg seems to be a safe bet.
# fetches VMs from VMSSs
include_vmss_resource_groups:
- ${customer_resource_group}

hostvar_expressions:
  spr_interfaces_efs_mount: tags.sftp_mnt_dir
  spr_azure_resource_group: resource_group
  spr_productname: "'sftp_interface'"
  spr_nodetype: "'sftp'"
  spr_landscape: tags.spr_landscape
  spr_azure_customer_storage_account: "'${customer_storage_account}'"
  spr_azure_customer_file_share: "'${customer_sftp_nfs}'"

#only include VMs with the following tag defined
exclude_host_filters:
- tags['sftp_mnt_dir'] is not defined
...
