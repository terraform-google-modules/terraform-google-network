# Routes
moved {
  from = aws_route.customer_default_management_peer
  to   = aws_route.customer_management_peer["default"]
}

moved {
  from = aws_route.customer_nat_management_peer_1a
  to   = aws_route.customer_management_peer["a"]
}

moved {
  from = aws_route.customer_nat_management_peer_1b
  to   = aws_route.customer_management_peer["b"]
}

moved {
  from = aws_route.customer_nat_management_peer_1c
  to   = aws_route.customer_management_peer["c"]
}
