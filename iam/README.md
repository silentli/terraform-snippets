# IAM Policies

Customer-managed IAM policy JSON files for use with the `iam-ec2` module.

## Available Policies

- **`ssm-policy.json`** - SSM Session Manager and Parameter Store access for EC2 instances
- **`packer-policy.json`** - Permissions for Packer to build AMIs on EC2 instances

## Usage

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