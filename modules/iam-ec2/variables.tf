variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "enable_managed_policies" {
  description = "Whether to attach AWS managed policies (policy_arns) to the EC2 role"
  type        = bool
  default     = false
}

variable "enable_custom_policies" {
  description = "Whether to create and attach customer-managed policies (policies) to the EC2 role"
  type        = bool
  default     = false
}

variable "policy_arns" {
  description = "Map of AWS managed IAM policy ARNs to attach to the EC2 role. Key is used for resource naming, value is the policy ARN. Example: { ssm = \"arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore\" }"
  type        = map(string)
  default     = {}
}

variable "policies" {
  description = "Map of customer-managed IAM policies. Key is used for resource naming, value is the policy JSON document (string) from file(). Example: { ssm = file(\"${path.module}/../../iam/ssm-policy.json\") }"
  type        = map(string)
  default     = {}
  
  validation {
    condition = alltrue([
      for k, v in var.policies : can(jsondecode(v))
    ])
    error_message = "Each policy value must be a valid JSON string. Use file() to load JSON policy files."
  }
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
