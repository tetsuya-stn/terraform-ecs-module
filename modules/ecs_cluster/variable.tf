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

variable "container_insights" {
  type        = bool
  description = ""
  default     = false
}

variable "enable_execute_command" {
  type        = bool
  description = ""
  default     = false
}

variable "cluster_configuration" {
  type        = any
  description = ""
}
