

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
  from = aws_subnet.customer_dataservices_1a
  to   = aws_subnet.customer_subnets["dataservices_1"]
}
moved {
  from = aws_subnet.customer_dataservices_1b
  to   = aws_subnet.customer_subnets["dataservices_2"]
}
moved {
  from = aws_subnet.customer_staging_1a
  to   = aws_subnet.customer_subnets["staging_1"]
}
moved {
  from = aws_subnet.customer_staging_1b
  to   = aws_subnet.customer_subnets["staging_2"]
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
  from = aws_eip.vpc_ngw1_eip
  to   = aws_eip.main["a"]
}
moved {
  from = aws_eip.vpc_ngw2_eip
  to   = aws_eip.main["b"]
}
moved {
  from = aws_nat_gateway.customer_ngw1
  to   = aws_nat_gateway.main["a"]
}
moved {
  from = aws_nat_gateway.customer_ngw2
  to   = aws_nat_gateway.main["b"]
}


# Route Tables, Routes, Etc.
moved {
  from = aws_route_table.customer_nat_gateway_route
  to   = aws_route_table.nat["a"]
}
moved {
  from = aws_route_table.customer_nat_gateway_route_b
  to   = aws_route_table.nat["b"]
}
moved {
  from = aws_route.customer_nat_gateway
  to   = aws_route.nat["a"]
}
moved {
  from = aws_route.customer_nat_gateway_b
  to   = aws_route.nat["b"]
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
  from = aws_route_table_association.customer_dataservices_1a
  to   = aws_route_table_association.customer_subnets["dataservices_1"]
}
moved {
  from = aws_route_table_association.customer_dataservices_1b
  to   = aws_route_table_association.customer_subnets["dataservices_2"]
}
moved {
  from = aws_route_table_association.customer_staging_1a
  to   = aws_route_table_association.customer_subnets["staging_1"]
}
moved {
  from = aws_vpc_endpoint_route_table_association.customer_nat_gateway_route
  to   = aws_vpc_endpoint_route_table_association.nat["a"]
}
