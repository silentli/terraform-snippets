output "bucket_name" {
  description = "Name of the S3 bucket for Terraform remote state"
  value       = module.s3_backend.bucket_name
}

output "bucket_arn" {
  description = "ARN of the S3 bucket for Terraform remote state"
  value       = module.s3_backend.bucket_arn
}

output "bucket_domain_name" {
  description = "Domain name of the S3 bucket"
  value       = module.s3_backend.bucket_domain_name
}

# OIDC Outputs
output "oidc_provider_arn" {
  description = "ARN of the OIDC identity provider for GitHub Actions"
  value       = module.oidc.oidc_provider_arn
}

output "oidc_provider_url" {
  description = "URL of the OIDC identity provider"
  value       = module.oidc.oidc_provider_url
}

# IAM Role Outputs
output "terraform_bootstrap_role_arn" {
  description = "ARN of the Terraform bootstrap IAM role"
  value       = aws_iam_role.terraform_bootstrap.arn
}

output "terraform_network_role_arn" {
  description = "ARN of the Terraform network IAM role"
  value       = module.iam_network.terraform_network_role_arn
}

output "terraform_compute_role_arn" {
  description = "ARN of the Terraform compute IAM role"
  value       = module.iam_compute.terraform_compute_role_arn
}

# Backend Configuration Outputs
output "backend_config" {
  description = "Terraform backend configuration for other layers"
  value       = module.s3_backend.backend_config
}

output "backend_config_network" {
  description = "Terraform backend configuration for network layer"
  value       = module.s3_backend.backend_config_network
}

output "backend_config_compute" {
  description = "Terraform backend configuration for compute layer"
  value       = module.s3_backend.backend_config_compute
}
