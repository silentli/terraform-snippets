variable "project_name" {
  description = "Project name for resource naming"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "enable_policies" {
  description = "Whether to attach IAM managed policies to the EC2 role"
  type        = bool
  default     = false
}

variable "policy_arns" {
  description = "Map of IAM policy ARNs to attach to the EC2 role. Key is used for resource naming, value is the policy ARN. Example: { ssm = \"arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore\" }"
  type        = map(string)
  default     = {}
}
