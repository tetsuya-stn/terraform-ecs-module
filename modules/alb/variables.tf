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

variable "subnet_ids" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}