/*
  Description: Outputs data from the module; Contains commonly used outputs needed by other modules and dependent automation
*/

###### Virtual Machines
output "instance_list" { value = merge(module.instance_list, local.output_windows_instance) }
output "windows_instance_list" { value = local.output_windows_instance }
output "instance_list_saprouter" { value = module.instance_saprouter }
output "raw_instance_list" { value = var.instance_list }
