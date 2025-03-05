

# Subnets
moved {
  from = aws_subnet.customer_production_1a
  to   = aws_subnet.customer_subnets["production_1"]
}
moved {
  from = aws_subnet.customer_production_1b
  to   = aws_subnet.customer_subnets["production_2"]
}
moved {
  from = aws_subnet.customer_production_1c
  to   = aws_subnet.customer_subnets["production_3"]
}
moved {
  from = aws_subnet.customer_quality_assurance_1a
  to   = aws_subnet.customer_subnets["quality_assurance_1"]
}
moved {
  from = aws_subnet.customer_quality_assurance_1b
  to   = aws_subnet.customer_subnets["quality_assurance_2"]
}
moved {
  from = aws_subnet.customer_quality_assurance_1c
  to   = aws_subnet.customer_subnets["quality_assurance_3"]
}
moved {
  from = aws_subnet.customer_development_1a
  to   = aws_subnet.customer_subnets["development_1"]
}
moved {
  from = aws_subnet.customer_development_1b
  to   = aws_subnet.customer_subnets["development_2"]
}
moved {
  from = aws_subnet.customer_development_1c
  to   = aws_subnet.customer_subnets["development_3"]
}
moved {
  from = aws_subnet.customer_edge_1a
  to   = aws_subnet.customer_subnets["edge_1"]
}
moved {
  from = aws_subnet.customer_edge_1b
  to   = aws_subnet.customer_subnets["edge_2"]
}
moved {
  from = aws_subnet.customer_edge_1c
  to   = aws_subnet.customer_subnets["edge_3"]
}


# Gateways
moved {
  from = aws_eip.customer_ngw1a[0]
  to   = aws_eip.main["a"]
}
moved {
  from = aws_nat_gateway.customer_ngw1a[0]
  to   = aws_nat_gateway.main["a"]
}
moved {
  from = aws_eip.customer_ngw1b[0]
  to   = aws_eip.main["b"]
}
moved {
  from = aws_nat_gateway.customer_ngw1b[0]
  to   = aws_nat_gateway.main["b"]
}
moved {
  from = aws_eip.customer_ngw1c[0]
  to   = aws_eip.main["c"]
}
moved {
  from = aws_nat_gateway.customer_ngw1c[0]
  to   = aws_nat_gateway.main["c"]
}

# Route Tables, Routes, Etc.
moved {
  from = aws_route_table.customer_ngw1a
  to   = aws_route_table.customer_nat["a"]
}
moved {
  from = aws_route.customer_ngw1a[0]
  to   = aws_route.customer_nat["a"]
}
moved {
  from = aws_route_table.customer_ngw1b
  to   = aws_route_table.customer_nat["b"]
}
moved {
  from = aws_route.customer_ngw1b[0]
  to   = aws_route.customer_nat["b"]
}
moved {
  from = aws_route_table.customer_ngw1c
  to   = aws_route_table.customer_nat["c"]
}
moved {
  from = aws_route.customer_ngw1c[0]
  to   = aws_route.customer_nat["c"]
}
moved {
  from = aws_route_table_association.customer_production_1a
  to   = aws_route_table_association.customer_subnets["production_1"]
}
moved {
  from = aws_route_table_association.customer_production_1b
  to   = aws_route_table_association.customer_subnets["production_2"]
}
moved {
  from = aws_route_table_association.customer_production_1c
  to   = aws_route_table_association.customer_subnets["production_3"]
}
moved {
  from = aws_route_table_association.customer_quality_assurance_1a
  to   = aws_route_table_association.customer_subnets["quality_assurance_1"]
}
moved {
  from = aws_route_table_association.customer_quality_assurance_1b
  to   = aws_route_table_association.customer_subnets["quality_assurance_2"]
}
moved {
  from = aws_route_table_association.customer_quality_assurance_1c
  to   = aws_route_table_association.customer_subnets["quality_assurance_3"]
}
moved {
  from = aws_route_table_association.customer_development_1a
  to   = aws_route_table_association.customer_subnets["development_1"]
}
moved {
  from = aws_route_table_association.customer_development_1b
  to   = aws_route_table_association.customer_subnets["development_2"]
}
moved {
  from = aws_route_table_association.customer_development_1c
  to   = aws_route_table_association.customer_subnets["development_3"]
}
moved {
  from = aws_vpc_endpoint_route_table_association.customer_ngw1a
  to   = aws_vpc_endpoint_route_table_association.customer_nat["a"]
}
moved {
  from = aws_vpc_endpoint_route_table_association.customer_ngw1b
  to   = aws_vpc_endpoint_route_table_association.customer_nat["b"]
}
moved {
  from = aws_vpc_endpoint_route_table_association.customer_ngw1c
  to   = aws_vpc_endpoint_route_table_association.customer_nat["c"]
}

# EFS

moved {
  from = aws_efs_mount_target.customer_usr_sap_trans_1a
  to   = aws_efs_mount_target.customer_usr_sap_trans["production_1"] #FIX
}
moved {
  from = aws_efs_mount_target.customer_usr_sap_trans_1b
  to   = aws_efs_mount_target.customer_usr_sap_trans["production_2"] #FIX
}
moved {
  from = aws_efs_mount_target.customer_usr_sap_trans_1c
  to   = aws_efs_mount_target.customer_usr_sap_trans["production_3"] #FIX
}
