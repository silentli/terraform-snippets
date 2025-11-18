# Compute Layer Variables

variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (e.g., Amazon Linux 2 AMI)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Name of an existing AWS key pair for SSH access. Set to null if using SSM Session Manager only"
  type        = string
  default     = null
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "terraform-instance"
}

variable "network_state_bucket" {
  description = "S3 bucket name for network layer state"
  type        = string
}

variable "aws_region" {
  description = "AWS region for remote state access"
  type        = string
  default     = "us-east-1"
}

# Policy usage:
# - Set `enable_policies = true` to attach policies to the EC2 role
# - Provide `policy_arns` as a map where the key is a friendly name
#   and the value is the policy ARN
#   Example:
#   policy_arns = {
#     ssm = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#   }
variable "enable_policies" {
  description = "Whether to attach IAM managed policies to the EC2 role"
  type        = bool
  default     = false
}

variable "policy_arns" {
  description = "Map of IAM policy ARNs to attach to the EC2 role. Key is used for resource naming, value is the policy ARN."
  type        = map(string)
  default     = {}
}

variable "enable_ssh" {
  description = "Enable SSH access (port 22). Set to false if using SSM Session Manager only"
  type        = bool
  default     = false
}

variable "additional_tags" {
  description = "Additional tags to apply to all resources (merged with common_tags)"
  type        = map(string)
  default     = {}
}
