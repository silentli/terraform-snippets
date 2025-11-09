# AWS Configuration

variable "region" {
  description = "AWS region for backend bucket"
  type        = string
  default     = "us-east-1"
}

# Project Configuration

variable "project_name" {
  description = "Project name for resource naming and tagging"
  type        = string
  # Example: "my-terraform-project"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  # Example: "dev"
}


# GitHub Configuration for OIDC

variable "github_org" {
  description = "GitHub organization name"
  type        = string
  # Example: "my-org"
}

variable "github_repo" {
  description = "GitHub repository name"
  type        = string
  # Example: "terraform-snippets"
}


# S3 Backend Configuration

variable "bucket_name" {
  description = "Name of S3 bucket for Terraform state (must be globally unique)"
  type        = string
  # Example: "my-terraform-state-bucket-dev"
}

variable "additional_tags" {
  description = "Additional tags to apply to all resources (merged with common_tags)"
  type        = map(string)
  default     = {}
}
