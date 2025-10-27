# Compute Layer

EC2 instances and compute resources.

## What It Creates

- **EC2 Instance**: Single instance with security group
- **Security Group**: SSH access and outbound traffic

## Required Variables

- `project_name`: Project name for resource naming
- `environment`: Environment (dev, staging, prod)
- `ami_id`: AMI ID for EC2 instance
- `instance_type`: EC2 instance type
- `key_name`: AWS key pair name
- `instance_name`: Instance name
- `network_state_bucket`: S3 bucket name (from bootstrap output)
- `region`: AWS region

## Dependencies

- Network layer must be deployed first
- Requires network state bucket from bootstrap
