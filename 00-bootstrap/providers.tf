# AWS Provider Configuration

provider "aws" {
  region = var.region

  # Default tags applied to all resources - simplified for best practices
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}
