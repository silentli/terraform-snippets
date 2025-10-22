####
# S3 Backend Module Outputs
####

output "bucket_name" {
  description = "Name of the S3 bucket for Terraform remote state"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 bucket for Terraform remote state"
  value       = aws_s3_bucket.terraform_state.arn
}

output "bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = aws_s3_bucket.terraform_state.bucket_domain_name
}

# Backend configuration outputs
output "backend_config" {
  description = "Terraform backend configuration for other layers"
  value = {
    bucket  = aws_s3_bucket.terraform_state.bucket
    key     = "terraform.tfstate"
    region  = "us-east-1"  # This should be passed as variable
    encrypt = true
  }
}

output "backend_config_network" {
  description = "Terraform backend configuration for network layer"
  value = {
    bucket  = aws_s3_bucket.terraform_state.bucket
    key     = "network/terraform.tfstate"
    region  = "us-east-1"  # This should be passed as variable
    encrypt = true
  }
}

output "backend_config_compute" {
  description = "Terraform backend configuration for compute layer"
  value = {
    bucket  = aws_s3_bucket.terraform_state.bucket
    key     = "compute/terraform.tfstate"
    region  = "us-east-1"  # This should be passed as variable
    encrypt = true
  }
}
