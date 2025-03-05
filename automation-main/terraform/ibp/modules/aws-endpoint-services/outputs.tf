/*
  Description: Output file of the module
  Comments:
*/

output "networkloadbalancer_dns_name" { value = aws_lb.networkloadbalancer.dns_name }
output "networkloadbalancer_id" { value = aws_lb.networkloadbalancer.id }
output "networkloadbalancer_name" { value = aws_lb.networkloadbalancer.name }
output "targetgroup_arn" { value = aws_lb_target_group.networkloadbalancer.arn }
output "endpoint_service_name" { value = aws_vpc_endpoint_service.networkloadbalancer.service_name }
output "endpoint_service_id" { value = aws_vpc_endpoint_service.networkloadbalancer.id }
output "endpoint_id" { value = aws_vpc_endpoint.networkloadbalancer.id }
output "endpoint_eni" { value = aws_vpc_endpoint.networkloadbalancer.network_interface_ids }
output "endpoint_dns_entry" { value = aws_vpc_endpoint.networkloadbalancer.dns_entry[*].dns_name }
