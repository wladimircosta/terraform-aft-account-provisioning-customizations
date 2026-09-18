# AWS Account Factory for Terraform (AFT) — Customizations

## Contexto

Este repositório documenta um trabalho de customização do **AWS Account Factory for Terraform (AFT)** realizado em contexto profissional, como parte de uma solução de provisionamento padronizado de contas AWS em escala.

> Por confidencialidade, o código específico do ambiente/cliente não está publicado aqui. Este README descreve o escopo técnico, a arquitetura geral e o papel desempenhado no projeto — sem expor dados, contas, nomes de clientes ou configurações internas.

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

## Impacto

A customização implementada permitiu provisionar contas de forma **consistente e repetível em múltiplas contas e ambientes**, reduzindo a variação manual de configuração entre elas e mantendo a aderência aos padrões definidos centralmente.

## Stack técnica

`Terraform` · `AWS Control Tower` · `AWS Organizations` · `AWS Account Factory for Terraform (AFT)` · `IAM` · `CI/CD (CodePipeline/CodeBuild)`

---

*Repositório mantido como registro técnico da experiência profissional com AFT. Repositórios de estudo (forks de tutoriais) são mantidos separadamente e não representam este trabalho.*

