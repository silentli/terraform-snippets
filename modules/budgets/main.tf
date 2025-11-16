# AWS Budget Module

locals {
  # Cost filters configuration
  # Note: If var.service is provided, it should be the full AWS service name
  # Set var.service = null to include all services
  cost_filters = var.service == null ? {
    TagKeyValue = ["${var.tag_key}$${var.tag_value}"]
  } : {
    TagKeyValue = ["${var.tag_key}$${var.tag_value}"]
    Service     = [var.service]
  }
}

# AWS Budget Resource
resource "aws_budgets_budget" "this" {
  name         = var.name
  budget_type  = "COST"
  limit_amount = var.limit_amount
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  # Cost filters - filter by tags and optionally by service
  cost_filters = local.cost_filters

  # Notification configuration
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type            = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.email]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type            = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.email]
  }

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type            = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.email]
  }
}
