/*
  Description: Terraform outputs
  Comments: N/A
*/

##### EFS
output "efs_usr_sap_trans" { value = {
  id       = aws_efs_file_system.customer_usr_sap_trans.id
  dns_name = aws_efs_file_system.customer_usr_sap_trans.dns_name
  arn      = aws_efs_file_system.customer_usr_sap_trans.arn
  mount_targets = {
    "1a" = {
      id                     = aws_efs_mount_target.customer_usr_sap_trans_1a.id
      file_system_arn        = aws_efs_mount_target.customer_usr_sap_trans_1a.file_system_arn
      availability_zone_id   = aws_efs_mount_target.customer_usr_sap_trans_1a.availability_zone_id
      availability_zone_name = aws_efs_mount_target.customer_usr_sap_trans_1a.availability_zone_name
      mount_target_dns_name  = aws_efs_mount_target.customer_usr_sap_trans_1a.mount_target_dns_name
      security_groups        = aws_efs_mount_target.customer_usr_sap_trans_1a.security_groups
    }
    "1b" = {
      id                     = aws_efs_mount_target.customer_usr_sap_trans_1b.id
      file_system_arn        = aws_efs_mount_target.customer_usr_sap_trans_1b.file_system_arn
      availability_zone_id   = aws_efs_mount_target.customer_usr_sap_trans_1b.availability_zone_id
      availability_zone_name = aws_efs_mount_target.customer_usr_sap_trans_1a.availability_zone_name
      mount_target_dns_name  = aws_efs_mount_target.customer_usr_sap_trans_1b.mount_target_dns_name
      security_groups        = aws_efs_mount_target.customer_usr_sap_trans_1b.security_groups
    }
    "1c" = {
      id                     = aws_efs_mount_target.customer_usr_sap_trans_1c.id
      file_system_arn        = aws_efs_mount_target.customer_usr_sap_trans_1c.file_system_arn
      availability_zone_id   = aws_efs_mount_target.customer_usr_sap_trans_1c.availability_zone_id
      availability_zone_name = aws_efs_mount_target.customer_usr_sap_trans_1a.availability_zone_name
      mount_target_dns_name  = aws_efs_mount_target.customer_usr_sap_trans_1c.mount_target_dns_name
      security_groups        = aws_efs_mount_target.customer_usr_sap_trans_1c.security_groups
    }
  }
} }

##### Gateways
output "internet_gateway" { value = {
  name           = aws_internet_gateway.customer_igw.tags.Name
  id             = aws_internet_gateway.customer_igw.id
  route_table_id = aws_vpc.customer.default_route_table_id
} }
output "nat_gateway_1a" {
  value = var.custom_no_nat_gateways == false ? {
    name           = aws_nat_gateway.customer_ngw1a[0].tags.Name
    eip            = aws_eip.customer_ngw1a[0].public_ip
    id             = aws_nat_gateway.customer_ngw1a[0].id
    route_table_id = aws_route_table.customer_ngw1a.id
  } : null
}
output "nat_gateway_1b" {
  value = var.custom_no_nat_gateways == false ? {
    name           = aws_nat_gateway.customer_ngw1b[0].tags.Name
    eip            = aws_eip.customer_ngw1b[0].public_ip
    id             = aws_nat_gateway.customer_ngw1b[0].id
    route_table_id = aws_route_table.customer_ngw1b.id
  } : null
}
output "nat_gateway_1c" {
  value = var.custom_no_nat_gateways == false ? {
    name           = aws_nat_gateway.customer_ngw1c[0].tags.Name
    eip            = aws_eip.customer_ngw1c[0].public_ip
    id             = aws_nat_gateway.customer_ngw1c[0].id
    route_table_id = aws_route_table.customer_ngw1c.id
  } : null
}

##### Route53
output "route53_zone" {
  value = var.custom_no_local_dns_zone == false ? {
    id             = aws_route53_zone_association.customer[0].zone_id
    association_id = aws_route53_zone_association.customer[0].id
  } : null
}

##### Routes
output "route_table_default" { value = {
  id   = aws_default_route_table.customer_default_route.id
  name = aws_default_route_table.customer_default_route.tags.Name
} }
output "route_table_customer_ngw1a" { value = {
  id   = aws_route_table.customer_ngw1a.id
  name = aws_route_table.customer_ngw1a.tags.Name
} }
output "route_table_customer_ngw1b" { value = {
  id   = aws_route_table.customer_ngw1b.id
  name = aws_route_table.customer_ngw1b.tags.Name
} }
output "route_table_customer_ngw1c" { value = {
  id   = aws_route_table.customer_ngw1c.id
  name = aws_route_table.customer_ngw1c.tags.Name
} }
output "route_table" { value = {
  default = {
    name = aws_default_route_table.customer_default_route.tags.Name
    id   = aws_default_route_table.customer_default_route.id
  }
  ngw1a = {
    name = aws_route_table.customer_ngw1a.tags.Name
    id   = aws_route_table.customer_ngw1a.id
  }
  ngw1b = {
    name = aws_route_table.customer_ngw1b.tags.Name
    id   = aws_route_table.customer_ngw1b.id
  }
  ngw1c = {
    name = aws_route_table.customer_ngw1c.tags.Name
    id   = aws_route_table.customer_ngw1c.id
  }
} }


##### S3 Buckets
output "s3_backups" { value = module.s3_customer_backups }

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

##### Subnets
output "subnet_production_1a" { value = {
  name = aws_subnet.customer_production_1a.tags.Name
  id   = aws_subnet.customer_production_1a.id
} }
output "subnet_production_1b" { value = {
  name = aws_subnet.customer_production_1b.tags.Name
  id   = aws_subnet.customer_production_1b.id
} }
output "subnet_production_1c" { value = {
  name = aws_subnet.customer_production_1c.tags.Name
  id   = aws_subnet.customer_production_1c.id
} }
output "subnet_quality_assurance_1a" { value = {
  name = aws_subnet.customer_quality_assurance_1a.tags.Name
  id   = aws_subnet.customer_quality_assurance_1a.id
} }
output "subnet_quality_assurance_1b" { value = {
  name = aws_subnet.customer_quality_assurance_1b.tags.Name
  id   = aws_subnet.customer_quality_assurance_1b.id
} }
output "subnet_quality_assurance_1c" { value = {
  name = aws_subnet.customer_quality_assurance_1c.tags.Name
  id   = aws_subnet.customer_quality_assurance_1c.id
} }
output "subnet_development_1a" { value = {
  name = aws_subnet.customer_development_1a.tags.Name
  id   = aws_subnet.customer_development_1a.id
} }
output "subnet_development_1b" { value = {
  name = aws_subnet.customer_development_1b.tags.Name
  id   = aws_subnet.customer_development_1b.id
} }
output "subnet_development_1c" { value = {
  name = aws_subnet.customer_development_1c.tags.Name
  id   = aws_subnet.customer_development_1c.id
} }
output "subnet_edge_1a" { value = {
  name = aws_subnet.customer_edge_1a.tags.Name
  id   = aws_subnet.customer_edge_1a.id
} }
output "subnet_edge_1b" { value = {
  name = aws_subnet.customer_edge_1b.tags.Name
  id   = aws_subnet.customer_edge_1b.id
} }
output "subnet_edge_1c" { value = {
  name = aws_subnet.customer_edge_1c.tags.Name
  id   = aws_subnet.customer_edge_1c.id
} }

##### VPC
output "vpc_customer" { value = {
  name                     = aws_vpc.customer.tags.Name
  id                       = aws_vpc.customer.id
  description              = aws_vpc.customer.tags.Description
  cidr_block               = aws_vpc.customer.cidr_block
  s3_endpoint_id           = aws_vpc_endpoint.private_s3.id
  additional_endpoints_ids = aws_vpc_endpoint.additional_endpoints[*]
} }
