/*
  Description: Output file of the module
  Comments:
*/


output "loadbalancer" { value = {
  id         = aws_lb.main01.id
  dns_name   = aws_lb.main01.dns_name
  name       = aws_lb.main01.name
  arn_suffix = aws_lb.main01.arn_suffix
  targetgroups = {
    for key, value in aws_lb_target_group.main01 : key => {
      id         = value.id
      name       = value.name
      arn_suffix = value.arn_suffix
    }
  }
  listeners = {
    for key, value in aws_lb_listener.main01 : key => {
      id = value.id
    }
  }
} }

output "endpoint_service" { value = {
  id                 = aws_vpc_endpoint_service.main01.id
  arn                = aws_vpc_endpoint_service.main01.arn
  service_name       = aws_vpc_endpoint_service.main01.service_name
  availability_zones = aws_vpc_endpoint_service.main01.availability_zones
  az_ids             = [for subnet in data.aws_subnet.main01 : subnet.availability_zone_id]
} }

output "endpoint" { value = {
  for key, value in aws_vpc_endpoint.main01 : key => {
    id                    = value.id
    network_interface_ids = value.network_interface_ids
    dns_name              = value.dns_entry[*].dns_name
  }
} }
