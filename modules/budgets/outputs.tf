output "budget_id" {
  description = "The ID of the budget"
  value       = aws_budgets_budget.this.id
}

output "budget_name" {
  description = "The name of the budget"
  value       = aws_budgets_budget.this.name
}

output "budget_arn" {
  description = "The ARN of the budget"
  value       = aws_budgets_budget.this.arn
}
