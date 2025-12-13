# Packer Layer

IAM role and instance profile for Packer to build AMIs on EC2 instances.

## What It Creates

- **IAM Role**: Role for Packer build instances with permissions to create AMIs, manage EC2 resources, and write to Parameter Store
- **Instance Profile**: IAM instance profile that Packer build instances can use

## Required Variables

- `project_name` - Project name for resource naming
- `environment` - Environment (dev, staging, prod)

## Optional Variables

- `additional_tags` - Additional tags to apply to all resources. Default: `{}`

## Usage in Packer

Use the instance profile name in your Packer configuration:

```hcl
build {
  name = "example-ami"
  
  sources = ["source.amazon-ebs.example"]

  # Use the instance profile from this layer
  iam_instance_profile = "my-project-packer-dev"
}
```

## Notes

- No dependencies - can be deployed independently
- Uses `iam-ec2` module with `packer-policy.json`
- Includes permissions for EC2, AMI creation, and SSM Parameter Store access
