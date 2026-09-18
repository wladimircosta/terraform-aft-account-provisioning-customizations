variable "budget_limit_usd" {
  description = "Limite mensal de orçamento, em dólares."
  type        = number
}

variable "notification_emails" {
  description = "E-mails notificados quando o orçamento atinge os limites configurados."
  type        = list(string)
  default     = []
}

variable "account_id" {
  description = "ID da conta AWS associada ao orçamento (usado apenas para nomear o recurso)."
  type        = string
}

