/*
  Description: output
*/

output "endpoint_services" {
  value = module.lb.endpoint_services
}


output "endpoints" {
  value = module.lb.endpoints
}

output "vmss_private_ips" {
  value = module.sftp_pool.vmss_private_ips
}
