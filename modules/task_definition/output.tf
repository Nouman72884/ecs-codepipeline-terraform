output "task_definition_id" {
  value = aws_ecs_task_definition.task_definition.id
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.task_definition.arn
}