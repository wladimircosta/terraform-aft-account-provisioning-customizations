# Orçamento mensal por conta, com alertas em 80% do valor previsto e 100%
# do valor realizado, notificando os e-mails configurados.

resource "aws_budgets_budget" "monthly" {
  name         = "aft-account-${var.account_id}-monthly-budget"
  budget_type  = "COST"
  limit_amount = tostring(var.budget_limit_usd)
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  dynamic "notification" {
    for_each = length(var.notification_emails) > 0 ? [1] : []
    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = 80
      threshold_type             = "PERCENTAGE"
      notification_type          = "FORECASTED"
      subscriber_email_addresses = var.notification_emails
    }
  }

  dynamic "notification" {
    for_each = length(var.notification_emails) > 0 ? [1] : []
    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = 100
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = var.notification_emails
    }
  }
}

output "budget_arn" {
  value = aws_budgets_budget.monthly.arn
}

