# IAM Compute Module

Creates IAM role and policy for Terraform compute layer operations.

## Usage

```hcl
module "iam_compute" {
  source = "../modules/iam-compute"

  project_name      = "my-project"
  environment       = "dev"
  github_org        = "my-org"
  github_repo       = "my-repo"
  oidc_provider_arn = "arn:aws:iam::123456789012:oidc-provider/token.actions.githubusercontent.com"
}
```

## Variables

- `project_name` - Project name for resource naming
- `environment` - Environment name (dev, staging, prod)
- `github_org` - GitHub organization name
- `github_repo` - GitHub repository name
- `oidc_provider_arn` - ARN of the OIDC identity provider

## Outputs

- `terraform_compute_role_arn` - ARN of the Terraform compute IAM role
- `terraform_compute_role_name` - Name of the Terraform compute IAM role
- `terraform_compute_policy_arn` - ARN of the Terraform compute IAM policy

## Permissions

EC2 instance management, EBS volume operations, RDS database operations, Lambda function management, key pair management, snapshot operations.

## Security

Uses OIDC authentication with least privilege principle, scoped to specific GitHub repository and environment.
