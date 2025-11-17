# Cost Governance Variables

variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "budget_notification_email" {
  description = "Email address to receive budget notifications"
  type        = string
}

variable "default_budget_limit" {
  description = "Default budget limit in USD for all resources"
  type        = number
  default     = 1000
}

variable "additional_tags" {
  description = "Additional tags to apply to all resources (merged with common_tags)"
  type        = map(string)
  default     = {}
}
