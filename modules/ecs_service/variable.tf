variable "environment" {
  type        = string
  description = ""
}

variable "product_name" {
  type        = string
  description = ""
}

variable "role" {
  type        = string
  description = ""
}

variable "vpc_id" {
  type        = string
  description = ""
}

variable "subnet_ids" {
  type        = list(any)
  description = ""
}

variable "target_group_arn" {
  type        = string
  description = ""
}

variable "security_group_ids" {
  type        = list(any)
  description = ""
}

variable "container_port" {
  type        = number
  description = ""
}

variable "ecs_cluster_id" {
  type        = string
  description = ""
}

variable "enable_execute_command" {
  type        = bool
  description = ""
}

variable "is_blue_green_deployment" {
  type        = bool
  description = ""
}

variable "assign_public_ip" {
  type        = bool
  description = ""
}

variable "task_definition_arn" {
  type        = string
  description = ""
}
