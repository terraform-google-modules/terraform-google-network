/*
  Description: Terraform outputs
  Comments: N/A
*/

##### VPC
output "vpc_customer" {
  value = {
    name                     = aws_vpc.customer.tags.Name
    id                       = aws_vpc.customer.id
    description              = aws_vpc.customer.tags.Description
    arn                      = aws_vpc.customer.arn
    cidr_block               = aws_vpc.customer.cidr_block
    cidr_block_additional    = local.cidr_block_additional
    s3_endpoint_id           = aws_vpc_endpoint.private_s3.id
    additional_endpoints_ids = aws_vpc_endpoint.additional_endpoints[*]
    dhcp_options_id          = aws_vpc.customer.dhcp_options_id
    default_route_table_id   = aws_vpc.customer.default_route_table_id
  }
}

##### Gateways
output "internet_gateway" { value = {
  name           = aws_internet_gateway.customer_igw.tags.Name
  id             = aws_internet_gateway.customer_igw.id
  route_table_id = aws_vpc.customer.default_route_table_id
} }
output "nat_gateway" { value = {
  for key, value in local.nat_gateway_map : key => {
    name = aws_nat_gateway.main[key].tags.Name
    id   = aws_nat_gateway.main[key].id
    eip  = aws_eip.main[key].public_ip
  }
} }

##### Security Groups
output "security_group_vpc" { value = {
  id   = aws_security_group.customer_vpc.id
  name = aws_security_group.customer_vpc.name
} }
output "security_group_all_egress" { value = {
  id   = aws_security_group.customer_all_egress.id
  name = aws_security_group.customer_all_egress.name
} }
output "security_group_customer_access_management" { value = {
  id   = aws_security_group.customer_access_management.id
  name = aws_security_group.customer_access_management.name
} }

##### S3 Buckets
output "s3_backups" { value = module.s3_customer_backups }

##### AWS Backup Service
output "aws_backup_plan_id" { value = var.enable_backup == 1 ? aws_backup_plan.main01[0].id : "" }

##### EFS
output "efs_usr_sap_trans" { value = {
  id       = aws_efs_file_system.customer_usr_sap_trans.id
  dns_name = aws_efs_file_system.customer_usr_sap_trans.dns_name
  arn      = aws_efs_file_system.customer_usr_sap_trans.arn
  mount_targets = {
    for key, value in aws_efs_mount_target.customer_usr_sap_trans : "1${local.subnet_all_map["${key}"].zone}" => {
      id                     = value.id
      file_system_arn        = value.file_system_arn
      availability_zone_id   = value.availability_zone_id
      availability_zone_name = value.availability_zone_name
      mount_target_dns_name  = value.mount_target_dns_name
      security_groups        = value.security_groups
    }
  }
} }

output "efs_ha_app" { value = var.deploy_ha_efs ? {
  id = aws_efs_file_system.ha_app[0].id
  ip_address = { for key, value in aws_efs_mount_target.ha_app :
    key => value.ip_address
} } : null }


##### Route53
output "route53_zone" {
  value = var.custom_no_local_dns_zone == false ? {
    id             = aws_route53_zone_association.customer[0].zone_id
    association_id = aws_route53_zone_association.customer[0].id
  } : null
}

##### Routes
output "route_table" { value = merge(
  {
    default = {
      name = aws_default_route_table.customer_default_route.tags.Name
      id   = aws_default_route_table.customer_default_route.id
  } },
  {
    for key, value in local.nat_gateway_map : key => {
      name = aws_route_table.customer_nat[key].tags.Name
      id   = aws_route_table.customer_nat[key].id
  } }
) }

##### Subnets
output "subnets" { value = {
  for key, value in aws_subnet.customer_subnets : key => {
    name = value.tags.Name
    id   = value.id
  }
} }

###### Network
output "network" {
  value = var.network
}

