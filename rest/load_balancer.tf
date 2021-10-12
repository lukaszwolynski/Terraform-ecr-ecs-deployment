resource "aws_lb" "main" {
  name               = "containerLB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_port.id]
  subnets            = var.subnets_id

  enable_deletion_protection = false
}

resource "aws_alb_target_group" "main" {
  name        = "containerTargetGroup"
  port        = var.appPort
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/Charizard"
    unhealthy_threshold = "2"
  }
  depends_on = [aws_lb.main]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.main.arn
  port              = tostring(var.appPort)
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.arn
  }

  depends_on = [aws_lb.main, aws_alb_target_group.main]
}

output "alb_link" {
  value = aws_lb.main.dns_name
}
