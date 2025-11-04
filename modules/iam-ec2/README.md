# IAM EC2 Module

Creates IAM role and instance profile for EC2 instances with optional policy attachments.

## Usage

```hcl
module "iam_ec2" {
  source = "../modules/iam-ec2"

  project_name    = "my-project"
  environment     = "dev"
  enable_policies = true
  
  policy_arns = {
    ssm         = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    s3_readonly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }
}
```

## Variables

- `project_name` - Project name for resource naming
- `environment` - Environment name (dev, staging, prod)
- `enable_policies` - Whether to attach IAM policies. Default: `false`
- `policy_arns` - Map of policy ARNs. Key used for resource naming, value is policy ARN. Default: `{}`

## Outputs

- `iam_role_arn` - ARN of the IAM role
- `iam_role_name` - Name of the IAM role
- `instance_profile_name` - Name of the instance profile (use in EC2 `iam_instance_profile`)
- `instance_profile_arn` - ARN of the instance profile

## Notes

- Map keys are used for resource naming (e.g., `managed["ssm"]`)
- Set `enable_policies = false` to disable all policy attachments
- For SSM access, include `AmazonSSMManagedInstanceCore` in `policy_arns`
