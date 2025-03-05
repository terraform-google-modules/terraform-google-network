/*
  Description: Outputs of the IBP Customer Module; Commonly used values of the IBP Customer VPC
  Comments: N/A
*/

##### AWS Metadata
output "aws_account_id" { value = data.aws_caller_identity.current.account_id }
output "aws_caller_arn" { value = data.aws_caller_identity.current.arn }
output "aws_caller_user" { value = data.aws_caller_identity.current.user_id }

##### Management VPC
output "vpc_management_name" { value = data.aws_vpc.management.tags.Name }
output "vpc_management_id" { value = data.aws_vpc.management.id }
output "vpc_management_dhcp_opts" { value = data.aws_vpc.management.dhcp_options_id }
output "vpc_managemenet_cidr_block" { value = data.aws_vpc.management.cidr_block }
output "vpc_management_peering_connection_id" { value = aws_vpc_peering_connection.customer.id }

##### Customer VPC
output "vpc_customer_name" { value = aws_vpc.customer.tags.Name }
output "vpc_customer_id" { value = aws_vpc.customer.id }
output "vpc_customer_s3_endpoint_id" { value = aws_vpc_endpoint.private_s3.id }

##### Subnets
output "subnet_edge_1a_name" { value = aws_subnet.customer_edge_1a.tags.Name }
output "subnet_edge_1a_id" { value = aws_subnet.customer_edge_1a.id }

output "subnet_edge_1b_name" { value = aws_subnet.customer_edge_1b.tags.Name }
output "subnet_edge_1b_id" { value = aws_subnet.customer_edge_1b.id }

output "subnet_edge_1c_name" { value = aws_subnet.customer_edge_1c.tags.Name }
output "subnet_edge_1ca_id" { value = aws_subnet.customer_edge_1c.id }

output "subnet_production_1a_name" { value = aws_subnet.customer_production_1a.tags.Name }
output "subnet_production_1a_id" { value = aws_subnet.customer_production_1a.id }

output "subnet_production_1b_name" { value = aws_subnet.customer_production_1b.tags.Name }
output "subnet_production_1b_id" { value = aws_subnet.customer_production_1b.id }

output "subnet_staging_1a_name" { value = aws_subnet.customer_staging_1a.tags.Name }
output "subnet_staging_1a_id" { value = aws_subnet.customer_staging_1a.id }

output "subnet_dataservices_1a_name" { value = aws_subnet.customer_dataservices_1a.tags.Name }
output "subnet_dataservices_1a_id" { value = aws_subnet.customer_dataservices_1a.id }

output "subnet_dataservices_1b_name" { value = aws_subnet.customer_dataservices_1b.tags.Name }
output "subnet_dataservices_1b_id" { value = aws_subnet.customer_dataservices_1b.id }

output "subnet_dataservices2_1a_name" { value = aws_subnet.customer_dataservices2_1a.tags.Name }
output "subnet_dataservices2_1a_id" { value = aws_subnet.customer_dataservices2_1a.id }


##### Route Tables
output "route_table_default_id" { value = aws_vpc.customer.default_route_table_id }
output "route_table_nat_gateway_id" { value = aws_route_table.customer_nat_gateway_route.id }

##### Gateways
output "internet_gateway_id" { value = aws_internet_gateway.customer_igw.id }
output "nat_gateway_name" { value = aws_nat_gateway.customer_ngw1.tags.Name }
output "nat_gateway_eip" { value = aws_eip.vpc_ngw1_eip.public_ip }
output "nat_gateway_id" { value = aws_nat_gateway.customer_ngw1.id }
output "nat_gateway_route_table_id" { value = aws_route_table.customer_nat_gateway_route.id }

##### Security Groups
output "security_group_access_management_id" { value = aws_security_group.customer_access_management.id }
output "security_group_vpc_id" { value = aws_security_group.customer_vpc.id }
output "security_group_all_egress_id" { value = aws_security_group.customer_all_egress.id }

##### S3 Buckets
output "s3_bucket_backups_arn" { value = aws_s3_bucket.s3_backups.arn }
output "s3_bucket_backups_id" { value = aws_s3_bucket.s3_backups.id }
output "s3_bucket_binaries_arn" { value = aws_s3_bucket.s3_binaries.arn }
output "s3_bucket_binaries_id" { value = aws_s3_bucket.s3_binaries.id }
