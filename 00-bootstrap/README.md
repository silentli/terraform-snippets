# Terraform Bootstrap

Sets up foundational AWS infrastructure for Terraform state management and GitHub Actions OIDC authentication.

## What It Creates

- **S3 Bucket**: For storing Terraform state files (encrypted, versioned)
- **OIDC Provider**: For GitHub Actions authentication
- **IAM Roles**: Separate roles for bootstrap, network, and compute layers
- **Backend Configs**: Auto-generated backend files for other layers

## Quick Start

1. **Deploy bootstrap**:
   ```bash
   terraform init
   terraform plan -var-file="../envs/dev/bootstrap.tfvars"
   terraform apply -var-file="../envs/dev/bootstrap.tfvars"
   ```

2. **Get outputs**:
   ```bash
   terraform output
   ```

## Required Variables

- `project_name`: Project name for resource naming
- `environment`: Environment (dev, staging, prod)
- `github_org`: GitHub organization
- `github_repo`: GitHub repository
- `bucket_name`: S3 bucket name (globally unique)
- `region`: AWS region

## Architecture

```
Bootstrap (Local Backend)
├── OIDC Provider
├── IAM Roles (Bootstrap, Network, Compute)
└── S3 Backend
    ├── Network Layer (S3 Backend)
    └── Compute Layer (S3 Backend)
```

## Hybrid IAM Approach

- **Bootstrap IAM**: In `iam-bootstrap.tf` (project-specific)
- **Network/Compute IAM**: In modules (reusable across projects)

## GitHub Actions Setup

1. **Add repository secrets**:
   - `AWS_ROLE_ARN_BOOTSTRAP`: Bootstrap role ARN
   - `AWS_ROLE_ARN_NETWORK`: Network role ARN
   - `AWS_ROLE_ARN_COMPUTE`: Compute role ARN
   - `AWS_REGION`: AWS region

2. **Use in workflows**:
   ```yaml
   - name: Configure AWS credentials
     uses: aws-actions/configure-aws-credentials@v4
     with:
       role-to-assume: ${{ secrets.AWS_ROLE_ARN_BOOTSTRAP }}
       aws-region: ${{ secrets.AWS_REGION }}
   ```

## Outputs

- `terraform_bootstrap_role_arn`: Bootstrap role ARN
- `terraform_network_role_arn`: Network role ARN  
- `terraform_compute_role_arn`: Compute role ARN
- `bucket_name`: S3 bucket name
- `backend_config_*`: Backend configurations for other layers

## Security Features

- **Encryption**: AES256 encryption for state files
- **Versioning**: S3 versioning enabled
- **Access Control**: IAM roles with least privilege
- **OIDC**: No long-term credentials needed
- **Public Access**: Completely blocked

## Troubleshooting

- **Bucket name exists**: Choose a globally unique name
- **Insufficient permissions**: Check AWS credentials
- **OIDC provider exists**: May already exist in the account
