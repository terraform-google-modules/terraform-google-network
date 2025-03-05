/*
  Description: Outputs for IBP Customer Integrations Layer-00
  Comments: N/A
*/


output "alb_edge_cpids" { value = aws_lb.edge_cpids }
output "lb_target_group_edge_cpids" { value = aws_lb_target_group.edge_cpids }
