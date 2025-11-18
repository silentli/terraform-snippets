# Compute Layer

EC2 instances and compute resources.

## What It Creates

- **EC2 Instance**: Single instance attached to a security group with IAM instance profile
- **Security Group**: Optional SSH access and outbound traffic
- **IAM Role and Instance Profile**: Created via `iam-ec2` module with optional SSM support

## Required Variables

- `project_name`: Project name for resource naming
- `environment`: Environment (dev, staging, prod)
- `ami_id`: AMI ID for EC2 instance
- `instance_name`: Instance name
- `network_state_bucket`: S3 bucket name (from bootstrap output)
- `region`: AWS region

## Optional Variables

- `instance_type`: EC2 instance type (default: `t2.micro`)
- `key_name`: AWS key pair name for SSH. Set to `null` if using SSM only (default: `null`)
- `enable_ssh`: Enable SSH access on port 22 (default: `false`)
- `enable_policies`: Whether to attach IAM managed policies to the EC2 role (default: `false`)
- `policy_arns`: Map of IAM policy ARNs to attach. Example: `{ ssm = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" }` (default: `{}`)

## Dependencies

- Network layer must be deployed first
- Requires network state bucket from bootstrap

## Notes

- **SSM Session Manager (Recommended)**: Set `enable_policies = true` and include SSM policy: `{ ssm = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" }`. This provides secure access without SSH keys or opening port 22.
- **SSH Access**: Set `enable_ssh = true` and provide `key_name` if SSH access is needed. Not recommended if using SSM.
- The EC2 instance uses an IAM instance profile created by the `iam-ec2` module.
- Ingress and egress are managed with standalone resources (`aws_vpc_security_group_ingress_rule` and `aws_vpc_security_group_egress_rule`).
