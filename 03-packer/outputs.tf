# Packer Layer Outputs

output "iam_role_arn" {
  description = "ARN of the IAM role for Packer"
  value       = module.iam_packer.iam_role_arn
}

output "iam_role_name" {
  description = "Name of the IAM role for Packer"
  value       = module.iam_packer.iam_role_name
}

output "instance_profile_name" {
  description = "Name of the IAM instance profile for Packer (use in Packer build configuration)"
  value       = module.iam_packer.instance_profile_name
}

output "instance_profile_arn" {
  description = "ARN of the IAM instance profile for Packer"
  value       = module.iam_packer.instance_profile_arn
}
