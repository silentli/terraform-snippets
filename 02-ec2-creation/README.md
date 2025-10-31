# Compute Layer

EC2 instances and compute resources.

## What It Creates

- **EC2 Instance**: Single instance attached to a security group
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

## Notes

- The EC2 instance is associated with the security group using `vpc_security_group_ids`.
- Ingress and egress are managed with standalone resources (`aws_vpc_security_group_ingress_rule` and `aws_vpc_security_group_egress_rule`). Per the provider guidance, avoid mixing inline rules inside `aws_security_group` with standalone rule resources to prevent conflicts. See the Terraform Registry: [AWS Security Group resource docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group).
