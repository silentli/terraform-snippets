# Nginx EC2 Layer Variables

variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "instance_name" {
  description = "Name for the EC2 instance"
  type        = string
  default     = "nginx-instance"
}

variable "min_size" {
  description = "Minimum number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Desired number of instances in the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "health_check_type" {
  description = "Health check type for ASG. Use 'EC2' for basic instance status checks (no AMI config needed) or 'ELB' if using a load balancer"
  type        = string
  default     = "EC2"
  validation {
    condition     = contains(["EC2", "ELB"], var.health_check_type)
    error_message = "Health check type must be either 'EC2' or 'ELB'"
  }
}

variable "health_check_grace_period" {
  description = "Time (in seconds) after instance launch before health checks begin. Increase if your AMI needs time to fully boot and start services"
  type        = number
  default     = 300
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

variable "enable_https" {
  description = "Enable HTTPS access (port 443)"
  type        = bool
  default     = false
}

variable "policy_arns" {
  description = "IAM policy ARNs to attach to the EC2 role. SSM Session Manager should be included for secure access."
  type        = map(string)
  default     = {}
}

# Nginx Configuration Variables



variable "user_data" {
  description = "Custom user data script. If empty, uses default nginx configuration with variables above"
  type        = string
  default     = ""
}

variable "additional_tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
