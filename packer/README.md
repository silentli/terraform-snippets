# Packer - Nginx AMI Builder

Builds an Amazon Linux 2 AMI with Nginx pre-installed and pre-configured.

## Prerequisites

1. Packer installed (version 1.7.0+)
2. AWS credentials configured
3. IAM instance profile from `03-packer-iam` deployed

## Quick Start

### CI/CD Usage (Recommended)

In CI/CD pipelines, pass variables via environment variables:

```bash
# Optional: Specify VPC/subnet (if not provided, uses default VPC)
export PKR_VAR_vpc_id="vpc-xxxxxxxxx"
export PKR_VAR_subnet_id="subnet-xxxxxxxxx"

# Build AMI
packer init .
packer build -var-file="envs/${ENVIRONMENT}/packer.pkrvars.hcl" packer.pkr.hcl
```

**CI/CD Variables:**
- `PKR_VAR_vpc_id` - VPC ID (optional - if not specified, uses default VPC)
- `PKR_VAR_subnet_id` - Subnet ID (optional - if not specified, uses default VPC)
- `ENVIRONMENT` - Environment name (dev, staging, prod)

The `packer.pkrvars.hcl` file should contain:
- `iam_instance_profile` - From `03-packer-iam` Terraform output
- Other build configuration (region, instance_type, etc.)

### Local Development

For local testing:

```bash
# 1. Get IAM instance profile from 03-packer-iam
cd ../03-packer-iam
terraform output -raw instance_profile_name

# 2. Copy and edit environment variables file
cd ../packer
cp envs/dev/packer.pkrvars.hcl.example envs/dev/packer.pkrvars.hcl
# Edit envs/dev/packer.pkrvars.hcl and set iam_instance_profile

# 3. Build AMI (VPC and subnet are optional - if not provided, uses default VPC)
# Optional: export PKR_VAR_vpc_id="vpc-xxxxxxxxx"
# Optional: export PKR_VAR_subnet_id="subnet-xxxxxxxxx"
packer init .
packer build -var-file="envs/dev/packer.pkrvars.hcl" packer.pkr.hcl
```

## Files

- `packer.pkr.hcl` - Main configuration
- `variables.pkr.hcl` - Variable definitions
- `nginx.conf` - Base nginx config (includes `/etc/nginx/conf.d/*.conf`)
- `templates/index.html` - Default HTML page (baked into AMI)

## AMI Contents

The AMI includes:
- Nginx installed and enabled
- Base nginx configuration (`/etc/nginx/nginx.conf`) with `/etc/nginx/conf.d/*.conf` support
- Default index.html for testing
- Empty `/etc/nginx/conf.d/` directory ready for server blocks

Note: Configure server blocks via Terraform user_data at instance startup. Nginx is typically used as a reverse proxy.

## Usage

Use the built AMI in `04-nginx-ec2` Terraform project.
