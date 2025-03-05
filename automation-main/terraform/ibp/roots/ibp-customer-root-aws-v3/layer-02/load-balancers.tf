/*
  Description: Creates an Application Load Balancer for the customer
  Comments: The loadbalancer certificate must be generated and imported into
    AWS ACM before this code is executed
    TODO: Move this into a module
*/


locals {
  lb_subnet = [for key, value in var.cpids_lb_subnets :
    local.layer_00_outputs.infrastructure.subnets[value].id
  ]
}

resource "aws_lb" "cpids" {
  name                       = "${module.base_layer_context.customer}-cpids"
  internal                   = true
  load_balancer_type         = "application"
  enable_deletion_protection = false
  security_groups = [
    local.layer_00_outputs.infrastructure.security_group_vpc_id,
    local.layer_00_outputs.infrastructure.security_group_access_management_id
  ]
  subnets = local.lb_subnet
  tags = merge(module.base_layer_context.tags, {
    Name             = "${module.base_layer_context.resource_prefix}-cpids-loadbalancer"
    Description      = "CPIDS application loadbalancer"
    alb-fips-enabled = "" # Create FIPS-enabled application load balancer
  })
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_lb_target_group" "cpids" {
  name     = "${module.base_layer_context.customer}-cpids"
  port     = 80
  protocol = "HTTP"
  vpc_id   = local.layer_00_outputs.infrastructure.vpc_customer_id
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
  tags = merge(module.base_layer_context.tags, {
    Name        = "${module.base_layer_context.resource_prefix}-cpids-target"
    Description = "CPIDS loadbalancer target"
  })
  lifecycle {
    prevent_destroy = false
  }
}

##### Customer Load Balancer Target Registration
resource "aws_lb_target_group_attachment" "cpids" {
  target_group_arn = aws_lb_target_group.cpids.arn
  target_id        = module.instance_map["instance_cpids"].instance_id
  port             = 80
}

resource "aws_acm_certificate" "cpids_internal" {
  domain_name               = var.loadbalancer_cert_fqdn
  certificate_authority_arn = local.management_layer_01_outputs.pca_intermediate_arn
  tags = {
    BuildUser     = var.build_user
    Business      = module.base_layer_context.business
    Customer      = module.base_layer_context.customer
    Description   = "${module.base_layer_context.resource_prefix} CPIDS internal load balancer ssl certificate"
    Environment   = module.base_layer_context.environment
    Generated-By  = "terraform"
    Managed-By    = "terraform"
    Name          = "${module.base_layer_context.resource_prefix}-cpids"
    Owner         = module.base_layer_context.owner
    ProvisionDate = timestamp()
  }
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      tags["BuildUser"],
      tags["ProvisionDate"],
    ]
  }
}

##### Customer Load Balancer Listener
resource "aws_lb_listener" "cpids" {
  load_balancer_arn = aws_lb.cpids.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = aws_acm_certificate.cpids_internal.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cpids.arn
  }
}

resource "aws_route53_record" "cpids" {
  zone_id = local.management_layer_00_outputs.route53_zone_main01.id
  name    = aws_acm_certificate.cpids_internal.domain_name
  type    = "CNAME"
  ttl     = "300"
  records = [aws_lb.cpids.dns_name]
}
