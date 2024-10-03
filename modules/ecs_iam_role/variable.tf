variable "environment" {
  type        = string
  description = ""
}

variable "role" {
  type        = string
  description = ""
}

variable "product_name" {
  type        = string
  description = ""
}

variable "ecs_task_policy" {
  type        = string
  description = ""
  default     = ""
}

variable "ecs_task_execution_policy" {
  type        = string
  description = ""
  default     = ""
}
