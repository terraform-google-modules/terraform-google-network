/*
  Description: Terraform Outputs
  Comments: N/A
*/

##### Metadata variables
output "_context" { value = module.base_context.context }
output "_tags" { value = module.base_layer_context.tags }
output "_resource_prefix" { value = module.base_context.resource_prefix }
output "_friendly_name" { value = module.base_context.environment_values.kv.prefix_friendly_name }

##### Gateways
output "internet_gateway_main01" { value = { id = aws_internet_gateway.main01.id } }
output "nat_gateway_main01_nat_edge_1a" { value = {
  name = aws_nat_gateway.main01_nat_edge_1a.tags.Name
  id   = aws_nat_gateway.main01_nat_edge_1a.id
  eip  = aws_eip.main01_nat_edge_1a.public_ip
} }
output "nat_gateway_main01_nat_edge_1b" { value = {
  name = aws_nat_gateway.main01_nat_edge_1b.tags.Name
  id   = aws_nat_gateway.main01_nat_edge_1b.id
  eip  = aws_eip.main01_nat_edge_1b.public_ip
} }
output "nat_gateway_main01_nat_edge_1c" { value = {
  name = aws_nat_gateway.main01_nat_edge_1c.tags.Name
  id   = aws_nat_gateway.main01_nat_edge_1c.id
  eip  = aws_eip.main01_nat_edge_1c.public_ip
} }

##### Route53
output "route53_zone_main01" { value = {
  id   = aws_route53_zone.main01.zone_id
  fqdn = aws_route53_zone.main01.name
  name = aws_route53_zone.main01.name
  vpc_association_authorizations = [
    for vpc in aws_route53_vpc_association_authorization.main01 : vpc.vpc_id
] } }
output "route53_resolver_endpoint_main01_inbound" { value = {
  id     = aws_route53_resolver_endpoint.main01_inbound.id
  arn    = aws_route53_resolver_endpoint.main01_inbound.arn
  object = aws_route53_resolver_endpoint.main01_inbound
} }




##### Routes
output "route_table_main01_default" { value = {
  id   = aws_default_route_table.main01_default.id
  name = aws_default_route_table.main01_default.tags.Name
} }
output "route_table_main01_nat_edge_1a" { value = {
  id   = aws_route_table.main01_nat_edge_1a.id
  name = aws_route_table.main01_nat_edge_1a.tags.Name
} }
output "route_table_main01_nat_edge_1b" { value = {
  id   = aws_route_table.main01_nat_edge_1b.id
  name = aws_route_table.main01_nat_edge_1b.tags.Name
} }
output "route_table_main01_nat_edge_1c" { value = {
  id   = aws_route_table.main01_nat_edge_1c.id
  name = aws_route_table.main01_nat_edge_1c.tags.Name
} }

###### Security Groups
output "security_group_main01_vpc" { value = {
  id   = aws_security_group.main01_vpc.id
  name = aws_security_group.main01_vpc.tags.Name
} }
output "security_group_main01_relay" { value = {
  id   = aws_security_group.main01_relay.id
  name = aws_security_group.main01_relay.tags.Name
} }
output "security_group_main01_access_edge" { value = {
  id   = aws_security_group.main01_access_edge.id
  name = aws_security_group.main01_access_edge.tags.Name
} }
output "security_group_main01_access_edge_ssh" { value = {
  id   = aws_security_group.main01_access_edge_ssh.id
  name = aws_security_group.main01_access_edge_ssh.tags.Name
} }
output "security_group_main01_access_edge_nessus" { value = {
  id   = aws_security_group.main01_access_edge_nessus.id
  name = aws_security_group.main01_access_edge_nessus.tags.Name
} }
output "security_group_main01_all_egress" { value = {
  id   = aws_security_group.main01_all_egress.id
  name = aws_security_group.main01_all_egress.tags.Name
} }
output "security_group_main01_efs_common" { value = {
  id   = aws_security_group.main01_efs_common.id
  name = aws_security_group.main01_efs_common.tags.Name
} }

##### Subnets
output "subnet_main01_infrastructure_1a" { value = {
  name = aws_subnet.main01_infrastructure_1a.tags.Name
  id   = aws_subnet.main01_infrastructure_1a.id
} }

output "subnet_main01_infrastructure_1b" { value = {
  name = aws_subnet.main01_infrastructure_1b.tags.Name
  id   = aws_subnet.main01_infrastructure_1b.id
} }

output "subnet_main01_infrastructure_1c" { value = {
  name = aws_subnet.main01_infrastructure_1c.tags.Name
  id   = aws_subnet.main01_infrastructure_1c.id
} }

output "subnet_main01_edge_1a" { value = {
  name = aws_subnet.main01_edge_1a.tags.Name
  id   = aws_subnet.main01_edge_1a.id
} }

output "subnet_main01_edge_1b" { value = {
  name = aws_subnet.main01_edge_1b.tags.Name
  id   = aws_subnet.main01_edge_1b.id
} }

output "subnet_main01_edge_1c" { value = {
  name = aws_subnet.main01_edge_1c.tags.Name
  id   = aws_subnet.main01_edge_1c.id
} }

##### VPC
output "vpc_main01" { value = {
  name            = aws_vpc.main01.tags.Name
  id              = aws_vpc.main01.id
  cidr_block      = aws_vpc.main01.cidr_block
  description     = aws_vpc.main01.tags.Description
  dhcp_options_id = aws_vpc_dhcp_options.main01.id
} }
