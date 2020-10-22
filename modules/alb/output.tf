output "target_groups" {
  value = aws_lb_target_group.tgs
}

output "alb_listener_1" {
  value = aws_lb_listener.listener_1.arn
}

output "alb_listener_2" {
  value = aws_lb_listener.listener_2.arn
}