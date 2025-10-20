output "oidc_provider_arn" {
  description = "ARN of the OIDC identity provider for GitHub Actions"
  value       = aws_iam_openid_connect_provider.github.arn
}

output "oidc_provider_url" {
  description = "URL of the OIDC identity provider"
  value       = aws_iam_openid_connect_provider.github.url
}
