# IAM Network Module

Creates IAM role and policy for Terraform network layer operations.

## Usage

```hcl
module "iam_network" {
  source = "../modules/iam-network"

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

- `terraform_network_role_arn` - ARN of the Terraform network IAM role
- `terraform_network_role_name` - Name of the Terraform network IAM role
- `terraform_network_policy_arn` - ARN of the Terraform network IAM policy

## Permissions

VPC creation and management, subnet operations, internet gateway management, route table operations, security group management, NAT gateway operations, network ACL management.

## Security

Uses OIDC authentication with least privilege principle, scoped to specific GitHub repository and environment.
