output "terraform_network_role_arn" {
  description = "ARN of the Terraform network IAM role"
  value       = aws_iam_role.terraform_network.arn
}

output "terraform_network_role_name" {
  description = "Name of the Terraform network IAM role"
  value       = aws_iam_role.terraform_network.name
}

output "terraform_network_policy_arn" {
  description = "ARN of the Terraform network IAM policy"
  value       = aws_iam_policy.terraform_network.arn
}
