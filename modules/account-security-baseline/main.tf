# Baseline de segurança aplicado a toda conta imediatamente após o
# provisionamento: política de senha do IAM, bloqueio de acesso público a
# nível de conta no S3, e remoção de todas as regras do security group
# default de cada VPC existente na conta/região.

resource "aws_iam_account_password_policy" "this" {
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 24
}

resource "aws_s3_account_public_access_block" "this" {
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_vpcs" "all" {}

resource "aws_default_security_group" "locked_down" {
  for_each = toset(data.aws_vpcs.all.ids)
  vpc_id   = each.value

  # Sem blocos de ingress/egress: o Terraform remove todas as regras do
  # security group default, forçando que cargas de trabalho usem security
  # groups criados explicitamente.
}

output "password_policy_id" {
  value = aws_iam_account_password_policy.this.id
}

output "locked_down_default_security_groups" {
  value = [for sg in aws_default_security_group.locked_down : sg.id]
}

