/*
  Description: Loadbalancer and related resources
  Comments:
*/

resource "aws_lb" "public_alb" {
  name               = substr(random_id.module.hex, -30, -1)
  load_balancer_type = "application"
  subnets            = var.alb_info.subnet_mappings
  security_groups    = [aws_security_group.qtm_lb.id]
  tags               = merge(local.default_tags, {})
}

resource "aws_lb_listener" "public_alb_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = var.alb_info.adv_listener_port
  protocol          = "HTTPS"
  certificate_arn   = var.alb_info.certificate_arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_alb_target_group.arn
  }
  tags = merge(local.default_tags, {})
}

resource "aws_lb_target_group" "public_alb_target_group" {
  name     = substr(random_id.module.hex, -30, -1)
  port     = var.alb_info.adv_target_port
  protocol = "HTTPS"
  vpc_id   = var.vpc_info.id
  dynamic "health_check" {
    for_each = toset(var.alb_info.adv_health_check)
    content {
      enabled             = health_check.value.enabled
      healthy_threshold   = health_check.value.healthy_threshold
      unhealthy_threshold = health_check.value.unhealthy_threshold
      timeout             = health_check.value.timeout
      interval            = health_check.value.interval
      path                = health_check.value.path
      protocol            = health_check.value.protocol
      port                = health_check.value.port
    }
  }
  tags = merge(local.default_tags, {})
}

resource "aws_lb_target_group_attachment" "public_alb_target_group_attachment" {
  target_group_arn = aws_lb_target_group.public_alb_target_group.arn
  target_id        = module.instance_list["qtm_webdispatcher"].instance_id
  port             = 44301
}

output "loadbalancer" {
  description = "QTM Public Application Load Balancer"
  value = {
    arn  = aws_lb.public_alb.arn
    name = aws_lb.public_alb.name
    dns  = aws_lb.public_alb.dns_name
  }
}
