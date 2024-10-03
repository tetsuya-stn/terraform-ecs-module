resource "aws_ecs_service" "this" {
  name             = "${var.product_name}-${var.role}-${var.environment}-service"
  cluster          = var.ecs_cluster_id
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  task_definition  = var.task_definition_arn
  desired_count    = 1

  enable_execute_command            = var.enable_execute_command
  health_check_grace_period_seconds = 120

  deployment_controller {
    type = var.is_blue_green_deployment ? "CODE_DEPLOY" : "ECS"
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = "web" # "${var.role}-container"
    container_port   = var.container_port
  }

  network_configuration {
    assign_public_ip = var.assign_public_ip
    security_groups  = var.security_group_ids
    subnets          = var.subnet_ids
  }

  lifecycle {
    ignore_changes = [
      desired_count,
      task_definition,
      load_balancer,
    ]
  }
}
