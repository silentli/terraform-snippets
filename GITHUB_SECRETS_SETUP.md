# Required GitHub Secrets and Inputs

To run the workflows, set the following repository secrets and prepare required tfvars files.

## Required Secrets

### OIDC (recommended) — used by bootstrap/network/compute workflows
- `AWS_ROLE_ARN_BOOTSTRAP` — Bootstrap IAM role ARN
- `AWS_ROLE_ARN_NETWORK` — Network IAM role ARN
- `AWS_ROLE_ARN_COMPUTE` — Compute IAM role ARN
- `AWS_REGION` — AWS region (e.g., "us-east-1")

### User credentials — used by pre-bootstrap workflow
- `AWS_ACCESS_KEY_ID` — AWS access key ID
- `AWS_SECRET_ACCESS_KEY` — AWS secret access key
- `AWS_REGION` — AWS region (e.g., "us-east-1")

## Required tfvars files
Real (non-example) tfvars files are required by the workflows:
- `envs/<env>/bootstrap.tfvars`

Example files (e.g., `*.tfvars.example`) are for reference only and are not used by workflows.

## Notes
- `terraform-bootstrap.yml` assumes OIDC and requires `envs/<env>/bootstrap.tfvars`.
- `terraform-pre-bootstrap.yml` uses user credentials and requires `envs/<env>/bootstrap.tfvars`.
- Workflows are configured to use the specific auth method listed above; they do not auto-fallback between OIDC and user keys.
