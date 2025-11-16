# Budgets Module

Creates AWS Budgets for cost monitoring and alerting with tag-based filtering.

## Usage

```hcl
module "project_ai" {
  source       = "../modules/budgets"
  name         = "ai-project"
  limit_amount = 300
  tag_key      = "Project"
  tag_value    = "AI"
  email        = "team-ai@example.com"
  service      = null  # null = all services, or specify service name
}
```

## Variables

**Required:**
- `name`: Budget name
- `limit_amount`: Budget limit in USD
- `tag_key`: Tag key to filter costs by
- `tag_value`: Tag value to filter costs by
- `email`: Email for notifications

**Optional:**
- `service`: AWS service name (e.g., "Amazon Elastic Compute Cloud - Compute"). Set to `null` for all services

## Outputs

- `budget_id`, `budget_name`, `budget_arn`

## Notes

- Filters costs by resources tagged with `tag_key` and `tag_value`
- Sends email alerts at 80% and 100% thresholds (actual and forecasted)
- Monthly budget starting from current period
