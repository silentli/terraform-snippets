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
  description = "Name of an existing AWS key pair to enable SSH access"
  type        = string
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
