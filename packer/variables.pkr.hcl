# Packer Variable Definitions
# Variable values are provided via envs/*/packer.pkrvars.hcl files

variable "aws_region" {
  type        = string
  description = "AWS region to build the AMI in"
  default     = "us-east-1"
}

variable "project_name" {
  type        = string
  description = "Project name for resource naming"
  default     = "terraform-snippets"
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)"
  default     = "dev"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for building the AMI"
  default     = "t3.micro"
}

variable "ami_name" {
  type        = string
  description = "Name for the resulting AMI"
  default     = "nginx-ami"
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile name for Packer (from 03-packer-iam output)"
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to use for building (optional - if not specified, uses default VPC)"
  default     = ""
}

variable "vpc_id" {
  type        = string
  description = "VPC ID to use for building (optional - if not specified, uses default VPC)"
  default     = ""
}


