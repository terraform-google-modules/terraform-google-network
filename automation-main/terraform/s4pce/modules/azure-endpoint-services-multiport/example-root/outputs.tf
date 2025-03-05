/*
  Description: output
*/

output "endpoint_services" {
  value = module.lb.endpoint_services
}


output "endpoints" {
  value = module.lb.endpoints
}
