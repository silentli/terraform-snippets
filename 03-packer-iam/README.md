# Packer IAM

Creates IAM role and instance profile for Packer to build AMIs.

## Variables

**Required:**
- `project_name` - Project name for resource naming
- `environment` - Environment name (dev, staging, prod)

**Optional:**
- `additional_tags` - Additional tags (default: `{}`)

## Usage

Deploy with Terraform:

```bash
terraform init
terraform plan -var-file="envs/dev/packer.tfvars"
terraform apply
```

Use the instance profile in your Packer configuration:

```hcl
build {
  sources = ["source.amazon-ebs.example"]
  iam_instance_profile = "my-project-packer-dev"
}
```

## Deployment

No dependencies. Can be deployed independently.

