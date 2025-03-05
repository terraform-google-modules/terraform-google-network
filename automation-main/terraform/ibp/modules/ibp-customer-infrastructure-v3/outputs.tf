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
output "vpc_customer_cidr_block" { value = aws_vpc.customer.cidr_block }
output "vpc_customer_s3_endpoint_id" { value = aws_vpc_endpoint.private_s3.id }


##### Gateways
output "internet_gateway_id" { value = aws_internet_gateway.customer_igw.id }

##### Security Groups
output "security_group_access_management_id" { value = aws_security_group.customer_access_management.id }
output "security_group_access_management_name" { value = aws_security_group.customer_access_management.tags.Name }
output "security_group_vpc_id" { value = aws_security_group.customer_vpc.id }
output "security_group_all_egress_id" { value = aws_security_group.customer_all_egress.id }

##### S3 Buckets
output "s3_bucket_backups_arn" { value = aws_s3_bucket.s3_backups.arn }
output "s3_bucket_backups_id" { value = aws_s3_bucket.s3_backups.id }
output "s3_bucket_binaries_arn" { value = aws_s3_bucket.s3_binaries.arn }
output "s3_bucket_binaries_id" { value = aws_s3_bucket.s3_binaries.id }

##### AWS Backup Service
output "aws_backup_plan_id" { value = var.enable_backup == 1 ? aws_backup_plan.main01[0].id : "" }
