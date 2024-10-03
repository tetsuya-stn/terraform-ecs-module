output "ecs_task_role_arn" {
  description = "Task IAM role ARN"
  value       = try(aws_iam_role.ecs_task.arn, null)
}

output "ecs_task_execution_role_arn" {
  description = "Task execution IAM role ARN"
  value       = try(aws_iam_role.ecs_task_execution.arn, null)
}