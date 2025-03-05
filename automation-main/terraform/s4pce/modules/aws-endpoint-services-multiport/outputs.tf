/*
  Description: Output file of the module
  Comments:
*/


output "networkloadbalancer" { value = {
  id       = aws_lb.networkloadbalancer.id
  dns_name = aws_lb.networkloadbalancer.dns_name
  name     = aws_lb.networkloadbalancer.name
  targetgroups = {
    for key, value in aws_lb_target_group.networkloadbalancer : key => {
      id   = value.id
      name = value.name
    }
  }
  listeners = {
    for key, value in aws_lb_listener.networkloadbalancer : key => {
      id = value.id
    }
  }
} }

output "endpoint_service" { value = {
  id           = aws_vpc_endpoint_service.networkloadbalancer.id
  service_name = aws_vpc_endpoint_service.networkloadbalancer.service_name
} }

output "endpoint" { value = {
  id                    = aws_vpc_endpoint.networkloadbalancer.id
  network_interface_ids = aws_vpc_endpoint.networkloadbalancer.network_interface_ids
  dns_name              = aws_vpc_endpoint.networkloadbalancer.dns_entry[*].dns_name
} }
