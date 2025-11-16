variable "name" {
  description = "Name of the budget"
  type        = string
}

variable "limit_amount" {
  description = "Budget limit amount in USD"
  type        = number
}

variable "tag_key" {
  description = "Tag key to filter costs by. Resources must be tagged with this key for the budget to track their costs"
  type        = string
}

variable "tag_value" {
  description = "Tag value to filter costs by. Resources must be tagged with the matching tag_key and this value for the budget to track their costs"
  type        = string
}

variable "email" {
  description = "Email address to receive budget notifications at 80% and 100% thresholds"
  type        = string
}

variable "service" {
  description = "Optional AWS service name to filter costs by. Use the full service name (e.g., 'Amazon Elastic Compute Cloud - Compute', 'Amazon Simple Storage Service'). Set to null to include all services"
  type        = string
  default     = null
}
