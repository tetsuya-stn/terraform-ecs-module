# ECS
resource "aws_iam_role" "ecs_task" {
  name        = "${var.product_name}-${var.role}-${var.environment}-ecs-task-role"
  description = ""

  assume_role_policy = file("${path.module}/json/ecs-sts.json")
}

resource "aws_iam_policy" "ecs_task" {
  name = "${var.product_name}-${var.role}-${var.environment}-ecs-task-policy"

  policy = var.ecs_task_policy != "" ? var.ecs_task_policy : file("${path.module}/json/ecs_task_policy_example.json")
}

resource "aws_iam_role_policy_attachment" "ecs_task" {
  role       = aws_iam_role.ecs_task.name
  policy_arn = aws_iam_policy.ecs_task.arn
}

# ECS task execution
resource "aws_iam_role" "ecs_task_execution" {
  name        = "${var.product_name}-${var.role}-${var.environment}-ecs-task-execution-role"
  description = ""

  assume_role_policy = file("${path.module}/json/ecs-sts.json")
}

resource "aws_iam_policy" "ecs_task_execution" {
  name = "${var.product_name}-${var.role}-${var.environment}-ecs-task-execution-policy"

  policy = var.ecs_task_execution_policy != "" ? var.ecs_task_execution_policy : file("${path.module}/json/ecs_task_execution_policy_example.json")
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = aws_iam_policy.ecs_task_execution.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
