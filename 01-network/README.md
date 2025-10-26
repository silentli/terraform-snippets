# Network Layer

Creates VPC and networking infrastructure for the application.

## Usage

This layer creates:
- VPC with DNS support
- Public and private subnets
- Internet Gateway
- Route tables and associations

## Variables

- `project_name` - Project name for resource naming
- `environment` - Environment name (dev, staging, prod)
- `vpc_cidr` - CIDR block for the VPC (default: "10.0.0.0/16")
- `public_subnet_cidr` - CIDR block for the public subnet (default: "10.0.1.0/24")
- `private_subnet_cidr` - CIDR block for the private subnet (default: "10.0.2.0/24")
- `availability_zone` - Availability Zone for the subnets

## Outputs

- `vpc_id` - ID of the VPC
- `public_subnet_id` - ID of the public subnet
- `private_subnet_id` - ID of the private subnet
- `public_route_table_id` - ID of the public route table

## Dependencies

- Requires bootstrap layer to be deployed first
- Uses S3 backend for state storage
