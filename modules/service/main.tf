resource "aws_ecs_service" "service" {
  name            = var.service_name
  task_definition = var.task_definition_id
  cluster         = var.ecs_cluster_arn
  launch_type                        = "EC2"
  desired_count                      = 1
  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 100

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = var.instance_security_group_id
    assign_public_ip = true
  }

  dynamic "load_balancer" {
    for_each = var.target_groups
    content {
      target_group_arn = load_balancer.value.arn
      container_name   = "nginx"
      container_port   = var.container_port
    }
  }

  # load_balancer {
  #   target_group_arn = var.alb_target_groups_arn_0
  #   container_name   = var.service_name
  #   container_port   = var.container_port
  # }

  # load_balancer {
  #   target_group_arn = var.alb_target_groups_arn_1
  #   container_name   = var.service_name
  #   container_port   = var.container_port
  #}
  

  
}