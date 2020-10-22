locals {
  target_groups = ["primary", "secondary"]
}

resource "aws_lb" "alb" {
  name               = "${var.service_name}-service-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_security_group_id]
  subnets            = var.settings.public_subnet_ids

  tags = {
    Name = "${var.service_name}-service-alb"
  }
}

resource "aws_lb_target_group" "tgs" {
  count = length(local.target_groups)
  name  = "${var.service_name}-tg-${element(local.target_groups, count.index)}"

  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.settings.vpc_id
  target_type = "instance"

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "listener_1" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgs[0].arn
  }
}

resource "aws_lb_listener" "listener_2" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tgs[1].arn
  }
}
