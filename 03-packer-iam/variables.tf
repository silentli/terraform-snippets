# Packer Layer Variables

variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "additional_tags" {
  description = "Additional tags to apply to all resources (merged with common_tags)"
  type        = map(string)
  default     = {}
}
