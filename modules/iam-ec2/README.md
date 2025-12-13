# IAM EC2 Module

Creates IAM role and instance profile for EC2 instances with optional policy attachments. Supports both AWS managed policies and customer-managed policies.

## Usage

### With AWS managed policies

```hcl
module "iam_ec2" {
  source = "../modules/iam-ec2"

  project_name           = "my-project"
  environment            = "dev"
  enable_managed_policies = true
  
  policy_arns = {
    ssm = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }
}
```

### With customer-managed policies

```hcl
module "iam_ec2" {
  source = "../modules/iam-ec2"

  project_name          = "my-project"
  environment           = "dev"
  enable_custom_policies = true
  
  policies = {
    ssm    = file("${path.module}/iam/ssm-policy.json")
    packer = file("${path.module}/iam/packer-policy.json")
  }
}
```

### With both AWS managed and customer-managed policies

```hcl
module "iam_ec2" {
  source = "../modules/iam-ec2"

  project_name           = "my-project"
  environment            = "dev"
  enable_managed_policies = true
  enable_custom_policies  = true
  
  policy_arns = {
    s3_readonly = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  }
  
  policies = {
    ssm    = file("${path.module}/iam/ssm-policy.json")
    packer = file("${path.module}/iam/packer-policy.json")
  }
}
```

### Without policies

```hcl
module "iam_ec2" {
  source = "../modules/iam-ec2"

  project_name = "my-project"
  environment  = "dev"
  
  # No policy_arns or policies provided - no policies will be attached
}
```

## Variables

- `project_name` - Project name for resource naming
- `environment` - Environment name (dev, staging, prod)
- `enable_managed_policies` - Whether to attach AWS managed policies (`policy_arns`). Default: `false`
- `enable_custom_policies` - Whether to create and attach customer-managed policies (`policies`). Default: `false`
- `policy_arns` - Map of AWS managed IAM policy ARNs. Key used for resource naming, value is policy ARN. Default: `{}`
- `policies` - Map of customer-managed IAM policies. Key is used for resource naming, value must be a JSON string from `file()`. Example: `{ ssm = file("${path.module}/iam/ssm-policy.json") }`. Default: `{}`. **Note**: If `enable_custom_policies = true`, at least one policy must be provided.
- `common_tags` - Common tags to apply to all resources. Default: `{}`

## Outputs

- `iam_role_arn` - ARN of the IAM role
- `iam_role_name` - Name of the IAM role
- `instance_profile_name` - Name of the instance profile (use in EC2 `iam_instance_profile`)
- `instance_profile_arn` - ARN of the instance profile
- `custom_policy_arns` - Map of policy names to ARNs for created customer-managed policies

## Notes

- **AWS Managed Policies**: Use `enable_managed_policies = true` and provide `policy_arns` to attach existing AWS managed policies
- **Customer-Managed Policies**: Use `enable_custom_policies = true` and provide `policies` to create and attach custom policies. Policies should be JSON files from the `iam/` directory, loaded using `file()`
- **Validation**: If `enable_custom_policies = true`, at least one policy must be provided in `policies`
- Both flags can be used independently - you can enable one, both, or neither
- Policies are only created/attached when their respective flag is `true` and the corresponding map is non-empty
- Both types can be used together
- Map keys are used for resource naming (e.g., `custom["ssm"]` creates policy named `{project_name}-ssm-{environment}`)
- Policy JSON files should be placed in the `iam/` directory at the root of your project
- See `iam/README.md` for available policy examples and how to create custom policies
- Variable type is `map(string)` with validation to ensure valid JSON, providing better type safety
