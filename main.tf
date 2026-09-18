# ------------------------------------------------------------------------------
# terraform-aft-account-provisioning-customizations
#
# Implementação de referência das customizações aplicadas pelo AWS Account
# Factory for Terraform (AFT) imediatamente após o provisionamento de uma
# nova conta, antes de ela ser disponibilizada para uso (camada
# "Account Provisioning Customizations" do AFT).
#
# Este código reproduz, de forma genérica e sem nenhum dado do ambiente
# original, os mesmos padrões de customização aplicados no projeto
# profissional descrito no README: baseline de segurança, controle de
# orçamento e guardrails de compliance via AWS Config.
# ------------------------------------------------------------------------------

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.mandatory_tags
  }
}

data "aws_caller_identity" "current" {}

module "account_security_baseline" {
  source = "./modules/account-security-baseline"
  count  = var.enable_security_baseline ? 1 : 0
}

module "budget_alerts" {
  source              = "./modules/budget-alerts"
  budget_limit_usd    = var.budget_limit_usd
  notification_emails = var.budget_notification_emails
  account_id          = data.aws_caller_identity.current.account_id
}

module "config_baseline" {
  source = "./modules/config-baseline"
  count  = var.enable_config_baseline ? 1 : 0
}

