# Cost Governance Outputs

output "all_resources_budget_id" {
  description = "ID of the all resources budget"
  value       = module.all_resources_budget.budget_id
}

output "all_resources_budget_arn" {
  description = "ARN of the all resources budget"
  value       = module.all_resources_budget.budget_arn
}

output "all_resources_budget_name" {
  description = "Name of the all resources budget"
  value       = module.all_resources_budget.budget_name
}
