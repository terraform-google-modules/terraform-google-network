/*
  Description: Outputs of the Customer Module; Commonly used values of the Customer VNet
*/

##### Pass Inputs to Dependent Terraform Layers
output "base_context" { value = module.base_context.context }

###### Infrastructure
output "infrastructure" { value = module.s4pce_customer_infrastructure }
output "az_letter_mapping" { value = local.az_letter_mapping }

##### SSH Keypairs
output "ssh_customer_public_key" { value = var.ssh_customer_public_key }

##### Golden AMIs
output "golden_image_resource_group" { value = var.golden_image_resource_group }

output "unique_zones" { value = local.unique_zones }

output "lb_front_end_ip_zones" { value = var.lb_front_end_ip_zones }
