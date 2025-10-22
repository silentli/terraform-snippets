# S3 Backend Module

Creates S3 bucket and related resources for Terraform remote state storage.

## Usage

```hcl
module "s3_backend" {
  source = "../modules/s3-backend"

  bucket_name        = "my-terraform-state-dev"
  allowed_role_arns = [
    "arn:aws:iam::123456789012:role/terraform-bootstrap-dev",
    "arn:aws:iam::123456789012:role/terraform-network-dev"
  ]
}
```

## Variables

- `bucket_name` - Name of S3 bucket for Terraform state
- `allowed_role_arns` - List of IAM role ARNs allowed to access the bucket

## Outputs

- `bucket_name` - Name of the S3 bucket
- `bucket_arn` - ARN of the S3 bucket
- `bucket_domain_name` - Domain name of the S3 bucket
- `backend_config` - General backend configuration
- `backend_config_network` - Network layer backend configuration
- `backend_config_compute` - Compute layer backend configuration

## Security Features

- AES256 encryption for all objects
- Versioning enabled for rollback capability
- Public access completely blocked
- Access restricted to specified IAM roles
- SSL/TLS enforced for all connections