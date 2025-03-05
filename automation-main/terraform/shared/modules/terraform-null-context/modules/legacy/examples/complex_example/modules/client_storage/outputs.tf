/*
  Description: Example outputs
  Comments:
    - N/A
*/

output "binaries_storage" {
  value = local.binaries_storage
}

output "dev_instance" {
  value = module.client_dev_module.instance
}
