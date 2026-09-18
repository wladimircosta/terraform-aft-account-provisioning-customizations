variable "aws_region" {
  description = "Região AWS onde as customizações de provisionamento serão aplicadas."
  type        = string
  default     = "us-east-1"
}

variable "mandatory_tags" {
  description = "Tags obrigatórias aplicadas via default_tags do provider a todo recurso criado na conta provisionada."
  type        = map(string)
  default = {
    ManagedBy   = "AFT"
    Environment = "production"
    CostCenter  = "unassigned"
  }
}

variable "budget_limit_usd" {
  description = "Limite mensal de orçamento (USD) configurado para cada conta recém-provisionada."
  type        = number
  default     = 1000
}

variable "budget_notification_emails" {
  description = "E-mails que recebem alertas de orçamento (previsto e realizado)."
  type        = list(string)
  default     = []
}

variable "enable_security_baseline" {
  description = "Habilita o baseline de segurança (password policy, S3 public access block, security group default bloqueado)."
  type        = bool
  default     = true
}

variable "enable_config_baseline" {
  description = "Habilita o baseline de AWS Config (recorder, delivery channel e regras gerenciadas) na conta provisionada."
  type        = bool
  default     = true
}

