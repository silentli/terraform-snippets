# Cost Governance

Cost monitoring and governance using AWS Budgets.

## Usage

Configure variables and deploy:

```hcl
# terraform.tfvars
project_name              = "my-project"
environment               = "dev"
budget_notification_email = "team@example.com"
default_budget_limit      = 1000
```

```bash
terraform init && terraform apply
```

## Variables

**Required:** `project_name`, `environment`, `budget_notification_email`  
**Optional:** `default_budget_limit` (default: `1000`), `additional_tags`

## Budgets

Budgets are configured in `budgets.tf`. Default budget tracks all resources tagged with `Project = <project_name>`. Add more budget modules as needed.
