# Environment Configurations

Configuration files for different deployment environments.

## Structure

```
envs/
├── dev/    # Development environment
│   ├── bootstrap.tfvars.example
│   ├── network.tfvars.example
│   └── ec2-compute.tfvars.example
└── prod/   # Production environment
    ├── bootstrap.tfvars.example
    ├── network.tfvars.example
    └── ec2-compute.tfvars.example
```

Each environment contains:
- `bootstrap.tfvars.example` - Bootstrap layer config
- `network.tfvars.example` - Network layer config  
- `ec2-compute.tfvars.example` - EC2 compute layer config

## Setup

1. **Create `.tfvars` files** (use `.example` files as reference)

2. **Set your values** in the `.tfvars` files:
   - `project_name`: Your project name
   - `bucket_name`: **Globally unique** S3 bucket name
   - `github_org` & `github_repo`: Your GitHub details
   - `region`: AWS region

3. **Deploy in order**:
   ```bash
   # Bootstrap
   cd 00-bootstrap && terraform apply -var-file="../envs/dev/bootstrap.tfvars"
   
   # Network  
   cd 01-network && terraform apply -var-file="../envs/dev/network.tfvars"
   
   # EC2 Compute
   cd 02-ec2-creation && terraform apply -var-file="../envs/dev/ec2-compute.tfvars"
   ```

## Security

- **Never commit `.tfvars` files** (excluded by `.gitignore`)
- **Use unique bucket names** (globally unique across AWS)
- **Use environment variables** for CI/CD
