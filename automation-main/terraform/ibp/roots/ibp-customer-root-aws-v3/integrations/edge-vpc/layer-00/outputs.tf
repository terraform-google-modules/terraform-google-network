/*
  Description: Terraform Outputs
  Comments: N/A
*/

###### Edge VPC
output "edge_vpc_id" { value = aws_vpc.edge_vpc.id }

###### Security Groups
output "security_group_edge_vpc_all_egress_id" { value = aws_security_group.edge_vpc_all_egress.id }
output "security_group_edge_vpc_ingress_id" { value = aws_security_group.edge_vpc_ingress.id }

###### Subnets
output "subnet_edge_vpc_1a_id" { value = aws_subnet.edge_vpc_1a.id }
output "subnet_edge_vpc_1b_id" { value = aws_subnet.edge_vpc_1b.id }

###### Endpoint
output "edge_cpids_endpoint" { value = module.endpoint_cpids }
output "edge_webdispatcher_44301_endpoint" { value = module.endpoint_webdispatcher_44301 }
output "edge_webdispatcher_44303_endpoint" { value = module.endpoint_webdispatcher_44303 }
output "cpids_endpoint_dns_entry" { value = module.endpoint_cpids.endpoint_dns_entry[0] }
