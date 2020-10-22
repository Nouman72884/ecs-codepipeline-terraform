resource "aws_ecs_task_definition" "task_definition" {
  family                   = var.service_name
  execution_role_arn       = var.execution_role
  task_role_arn            = var.task_role
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  container_definitions    = <<DEFINITION
[
   {
      "portMappings": [
        {
          "hostPort": 80,
          "protocol": "tcp",
          "containerPort": ${var.container_port}
        }
      ],
      "environment": [
        {
          "name": "PORT",
          "value": "80"
        },
        {
          "name" : "APP_NAME",
          "value": "${var.service_name}"
        }
      ],
      "memoryReservation" : 128,
      "image": "nginx:alpine",
      "name": "${var.service_name}"
    }
]
DEFINITION
}