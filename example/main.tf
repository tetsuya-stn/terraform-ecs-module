data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "alb" {
  source = "../modules/alb"

  environment     = terraform.workspace
  product_name    = "example"
  role            = "service"
  security_groups = [aws_security_group.alb.id]
  subnet_ids      = data.aws_subnets.default.ids
  vpc_id          = data.aws_vpc.default.id
}

module "ecs_cluster" {
  source = "../modules/ecs_cluster"

  environment  = terraform.workspace
  product_name = "example"
  role         = "service"

  enable_execute_command = true
  container_insights     = true
  cluster_configuration = {
    kms_key_id                   = ""
    s3_bucket_name               = "terraform-example-bukect-20240701"
    s3_bucket_encryption_enabled = true
    s3_key_prefix                = "example"
  }
}

module "ecs_iam_role" {
  source = "../modules/ecs_iam_role"

  environment               = terraform.workspace
  product_name              = "example"
  role                      = "service"
  ecs_task_execution_policy = <<EOT
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:List*"
      ],
      "Resource": ["*"]
    }
  ]
}
EOT

  ecs_task_policy = ""
}

module "ecs_task_definition" {
  source = "../modules/ecs_task_definition"

  environment                 = terraform.workspace
  product_name                = "example"
  role                        = "service"
  ecs_task_execution_role_arn = module.ecs_iam_role.ecs_task_execution_role_arn
  ecs_task_role_arn           = module.ecs_iam_role.ecs_task_role_arn
}

module "ecs_service" {
  source = "../modules/ecs_service"

  container_port           = 80
  ecs_cluster_id           = module.ecs_cluster.cluster_id
  environment              = terraform.workspace
  product_name             = "example"
  role                     = "service"
  is_blue_green_deployment = true
  assign_public_ip         = true
  enable_execute_command   = false
  security_group_ids       = [aws_security_group.ecs_service.id]
  subnet_ids               = data.aws_subnets.default.ids
  target_group_arn         = module.alb.target_group_arn
  task_definition_arn      = module.ecs_task_definition.ecs_task_definition_arn
  vpc_id                   = data.aws_vpc.default.id
}
