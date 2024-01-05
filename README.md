# Terraform Azure Blob Storage Module

[![Terraform CI](https://github.com/PashmakGuru/terraform-azure-blob-storage/actions/workflows/terraform-ci.yaml/badge.svg)](https://github.com/PashmakGuru/terraform-azure-blob-storage/actions/workflows/terraform-ci.yaml)

## Overview
This Terraform configuration is designed to facilitate the deployment and management of Azure Blob Storage resources. It offers an efficient way to create and manage storage accounts and containers in Azure.

### Terraform Architecture
```mermaid
%%tfmermaid
%%{init:{"theme":"default","themeVariables":{"lineColor":"#6f7682","textColor":"#6f7682"}}}%%
flowchart LR
classDef r fill:#5c4ee5,stroke:#444,color:#fff
classDef v fill:#eeedfc,stroke:#eeedfc,color:#5c4ee5
classDef ms fill:none,stroke:#dce0e6,stroke-width:2px
classDef vs fill:none,stroke:#dce0e6,stroke-width:4px,stroke-dasharray:10
classDef ps fill:none,stroke:none
classDef cs fill:#f7f8fa,stroke:#dce0e6,stroke-width:2px
subgraph "n0"["Base"]
n1["azurerm_resource_group.this"]:::r
end
class n0 cs
subgraph "n2"["Authorization"]
n3["azurerm_role_assignment.rbac"]:::r
n4{{"data.<br/>azurerm_user_assigned_identity.<br/>identity"}}:::r
end
class n2 cs
subgraph "n5"["Storage"]
n6["azurerm_storage_account.this"]:::r
n7["azurerm_storage_container.<br/>containers"]:::r
end
class n5 cs
n8["random_string.<br/>storage_account_postfix"]:::r
subgraph "n9"["Input Variables"]
na(["var.container_names"]):::v
nb(["var.environment"]):::v
nc(["var.location"]):::v
nd(["var.name"]):::v
ne(["var.rbac"]):::v
nf(["var.resource_group_name"]):::v
end
class n9 vs
ng(["local.common_tags"]):::v
nh(["local.rbac"]):::v
ni(["local.id"]):::v
subgraph "nj"["Output Values"]
nk(["output.containers"]):::v
nl(["output.storage_account"]):::v
end
class nj vs
ng-->n1
nc--->n1
nf--->n1
n7-->n3
n4-->n3
n1-->n6
n8-->n6
n6-->n7
na--->n7
nh-->n4
nb--->ng
nd--->ng
nb--->ni
nd--->ni
ne--->nh
n7--->nk
n6--->nl
```

## Features
- **Resource Group Creation**: Sets up an Azure resource group.
- **Storage Account Management**: Automates the creation of Azure Storage Accounts.
- **Storage Containers**: Handles the creation of multiple storage containers.
- **RBAC Configuration**: Manages role-based access control for the storage containers using user-assigned identities.

## File Structure
- [`01-providers.tf`](./01-providers.tf): Specifies the required providers such as AzureRM, Helm, AzAPI, Random, and AzureAD.
- [`outputs.tf`](./outputs.tf): Includes outputs like storage account and container details.
- [`variables.tf`](./variables.tf): Contains all the necessary variables like resource group name, location, environment, container names, and RBAC settings.

## Example
For examples on how to use this configuration, refer to the [`example`](./example) directory.

## Workflows
| Name | Description |
|---|---|
| [terraform-ci.yaml](.github/workflows/terraform-ci.yaml) | A workflow for linting and auto-formatting Terraform code. Triggered by pushes to  `main` and `dev` branches or on pull requests, it consists of two jobs: `tflint` for lint checks, `format` for code formatting and submit a PR, and `tfmermaid` to update architecture graph and submit a PR. |
