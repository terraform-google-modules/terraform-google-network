/*
  Description: Load Balancer configurations
*/

##### Customer Edge ALB
module "context_aws_lb_edge_cpids" {
  source      = "../../EXAMPLE_SOURCE/terraform/shared/modules/terraform-null-context/modules/legacy"
  context     = module.base_layer_context.context
  name        = "edge-vpc-cpids"
  description = "${module.base_layer_context.resource_prefix} edge vpc application load balancer"
}

resource "aws_lb" "edge_cpids" {
  name               = "${module.base_layer_context.customer}-edge-cpids"
  internal           = true
  load_balancer_type = "application"
  security_groups = [
    local.integration_layer_00_outputs.security_group_edge_vpc_all_egress_id,
    local.integration_layer_00_outputs.security_group_edge_vpc_ingress_id
  ]
  subnets = [
    local.integration_layer_00_outputs.subnet_edge_vpc_1a_id,
    local.integration_layer_00_outputs.subnet_edge_vpc_1b_id
  ]
  enable_deletion_protection = false
  tags = merge(module.context_aws_lb_edge_cpids.tags, {
    alb-fips-enabled = "" # Create FIPS-enabled application load balancer
  })
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_lb_target_group" "edge_cpids" {
  name        = "${module.base_layer_context.customer}-edge-cpids"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = local.integration_layer_00_outputs.edge_vpc_id
  target_type = "ip"
  health_check {
    enabled             = true
    path                = "/DSoD/session/logon"
    interval            = 30 # AWS Default
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5     # AWS Default
    healthy_threshold   = 5     # AWS Default
    unhealthy_threshold = 2     # AWS Default
    matcher             = "200" # AWS Default Success Code
  }
  tags = module.context_aws_lb_edge_cpids.tags
  lifecycle {
    prevent_destroy = false
  }
}

data "dns_a_record_set" "edge_cpids" {
  host = local.integration_layer_00_outputs.cpids_endpoint_dns_entry
}

resource "aws_lb_target_group_attachment" "edge_cpids" {
  count            = length(data.dns_a_record_set.edge_cpids.addrs)
  target_group_arn = aws_lb_target_group.edge_cpids.arn
  target_id        = data.dns_a_record_set.edge_cpids.addrs[count.index]
  port             = 80
}

resource "aws_lb_listener" "edge_cpids" {
  load_balancer_arn = aws_lb.edge_cpids.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = local.layer_02_outputs.certificate_cpids_internal_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.edge_cpids.arn
  }
}
##### End Customer Edge ALB
