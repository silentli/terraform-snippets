# Budgets Configuration

# Budget for all resources (service = null)
module "all_resources_budget" {
  source       = "../modules/budgets"
  name         = "${var.project_name}-all-resources"
  limit_amount = var.default_budget_limit
  tag_key      = "Project"
  tag_value    = var.project_name
  email        = var.budget_notification_email
  service      = null
}
