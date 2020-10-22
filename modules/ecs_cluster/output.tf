output "task_role" {
  value = aws_iam_role.task_role.arn
}

output "execution_role" {
  value = aws_iam_role.execution_role.arn
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.ecs_cluster.arn
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}