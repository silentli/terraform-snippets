# Network Module

Creates a basic AWS VPC network with VPC, public/private subnets, internet gateway, and route tables.

## Usage

```hcl
module "network" {
  source              = "../modules/network"
  project_name        = "my-project"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  availability_zone   = "us-east-1a"
}
```

## Variables

- `project_name` - Project name for resource naming
- `vpc_cidr` - CIDR block for the VPC (default: "10.0.0.0/16")
- `public_subnet_cidr` - CIDR block for the public subnet (default: "10.0.1.0/24")
- `private_subnet_cidr` - CIDR block for the private subnet (default: "10.0.2.0/24")
- `availability_zone` - Availability Zone for subnets
- `enable_dns_hostnames` - Enable DNS hostnames in the VPC (default: true)

## Outputs

- `vpc_id` - ID of the VPC
- `public_subnet_id` - ID of the public subnet
- `private_subnet_id` - ID of the private subnet
- `public_route_table_id` - ID of the public route table
