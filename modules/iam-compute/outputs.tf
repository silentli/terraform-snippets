output "terraform_compute_role_arn" {
  description = "ARN of the Terraform compute IAM role"
  value       = aws_iam_role.terraform_compute.arn
}

output "terraform_compute_role_name" {
  description = "Name of the Terraform compute IAM role"
  value       = aws_iam_role.terraform_compute.name
}

output "terraform_compute_policy_arn" {
  description = "ARN of the Terraform compute IAM policy"
  value       = aws_iam_policy.terraform_compute.arn
}
