resource "aws_ecs_task_definition" "this" {
  family                   = "${var.product_name}-${var.role}-${var.environment}-service"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256 # 構築時は初期値
  memory                   = 512 # 構築時は初期値
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.ecs_task_role_arn
  skip_destroy             = true

  container_definitions = file("${path.module}/json/task_definition_example.json") # 構築時は共通の初期設定

  lifecycle {
    ignore_changes = [
      container_definitions,
      cpu,
      memory,
    ]
  }
}
