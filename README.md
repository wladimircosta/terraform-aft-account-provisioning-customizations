# AWS Account Factory for Terraform (AFT) — Customizations

## Contexto

Este repositório documenta um trabalho de customização do **AWS Account Factory for Terraform (AFT)** realizado em contexto profissional, como parte de uma solução de provisionamento padronizado de contas AWS em escala.

> Por confidencialidade, o código original do cliente não é publicado aqui. O Terraform deste repositório é uma **implementação de referência**, escrita do zero, que reproduz os mesmos padrões de customização (baseline de segurança, orçamento e compliance via AWS Config) descritos abaixo — sem nenhum dado, identificador de conta ou configuração do ambiente original.

## O que é o AFT

O AWS Account Factory for Terraform é o framework oficial da AWS (integrado ao Control Tower) que automatiza o ciclo de vida de contas AWS usando Terraform. Ele é organizado em quatro repositórios de customização, cada um com uma responsabilidade distinta no fluxo de provisionamento.

## Escopo do trabalho

Este projeto cobriu as quatro camadas de customização do AFT:

- **Account Request** — parametrização e padronização das solicitações de novas contas AWS.
- **Account Provisioning Customizations** — automações executadas logo após a criação da conta (ex.: baseline de configuração pós-provisionamento).
- **Account Customizations** — customizações aplicadas a contas ou grupos específicos de contas, conforme seu propósito (produção, sandbox, etc.).
- **Global Customizations** — configurações e guardrails aplicados de forma consistente a todas as contas da organização.

## Arquitetura (visão geral)

Em alto nível, o AFT opera a partir de uma conta de gerenciamento dedicada, orquestrando pipelines de Terraform (via CodePipeline/CodeBuild) que são disparados a cada solicitação de conta processada pelo Account Factory, integrando-se ao AWS Organizations e ao Control Tower para manter a governança entre contas.

## Estrutura do repositório

```
.
├── main.tf                    # chamada dos módulos de customização
├── variables.tf                # parâmetros configuráveis (tags, orçamento, região)
├── outputs.tf                  # saídas (conta, orçamento, baselines habilitados)
├── versions.tf                 # versões do Terraform e do provider AWS
├── terraform.tfvars.example    # exemplo de configuração
└── modules/
    ├── account-security-baseline/  # password policy, S3 public access block, security group default bloqueado
    ├── budget-alerts/               # AWS Budgets com alertas por e-mail
    └── config-baseline/             # AWS Config (recorder + regras gerenciadas)
```

## Impacto

A customização implementada permitiu provisionar contas de forma **consistente e repetível em múltiplas contas e ambientes**, reduzindo a variação manual de configuração entre elas e mantendo a aderência aos padrões definidos centralmente.

## Stack técnica

`Terraform` · `AWS Control Tower` · `AWS Organizations` · `AWS Account Factory for Terraform (AFT)` · `IAM` · `AWS Config` · `AWS Budgets` · `CI/CD (CodePipeline/CodeBuild)`

---

*Repositório mantido como registro técnico da experiência profissional com AFT. Repositórios de estudo (forks de tutoriais) são mantidos separadamente e não representam este trabalho.*
