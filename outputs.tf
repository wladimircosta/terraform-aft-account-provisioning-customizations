output "account_id" {
  description = "ID da conta AWS onde as customizações de provisionamento foram aplicadas."
  value       = data.aws_caller_identity.current.account_id
}

output "security_baseline_enabled" {
  value = var.enable_security_baseline
}

output "config_baseline_enabled" {
  value = var.enable_config_baseline
}

output "budget_arn" {
  description = "ARN do orçamento (AWS Budgets) criado para a conta."
  value       = module.budget_alerts.budget_arn
}

