resource "aws_ecs_cluster" "this" {
  name = "${var.product_name}-${var.role}-${var.environment}-cluster"

  dynamic "configuration" {
    for_each = var.enable_execute_command ? [var.cluster_configuration] : []

    content {
      execute_command_configuration {
        kms_key_id = configuration.value.kms_key_id
        logging    = "OVERRIDE"

        log_configuration {
          s3_bucket_name               = configuration.value.s3_bucket_name
          s3_bucket_encryption_enabled = configuration.value.s3_bucket_encryption_enabled
          s3_key_prefix                = configuration.value.s3_key_prefix
        }
      }
    }
  }

  setting {
    name  = "containerInsights"
    value = var.container_insights ? "enabled" : "disabled"
  }
}
