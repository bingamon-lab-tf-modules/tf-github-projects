# tf-github-org-project

## Table of Contents

- [tf-github-org-project](#tf-github-org-project)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Documentation](#documentation)

## Overview

This module creates and configures a project inside a GitHub organization.

## Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | 6.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | 6.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_organization_project.this](https://registry.terraform.io/providers/integrations/github/6.7.0/docs/resources/organization_project) | resource |
| [github_project_card.this](https://registry.terraform.io/providers/integrations/github/6.7.0/docs/resources/project_card) | resource |
| [github_project_column.organization](https://registry.terraform.io/providers/integrations/github/6.7.0/docs/resources/project_column) | resource |
| [github_project_column.repository](https://registry.terraform.io/providers/integrations/github/6.7.0/docs/resources/project_column) | resource |
| [github_repository_project.this](https://registry.terraform.io/providers/integrations/github/6.7.0/docs/resources/repository_project) | resource |
| [github_enterprise.this](https://registry.terraform.io/providers/integrations/github/6.7.0/docs/data-sources/enterprise) | data source |
| [github_organization.this](https://registry.terraform.io/providers/integrations/github/6.7.0/docs/data-sources/organization) | data source |
| [github_repositories.this](https://registry.terraform.io/providers/integrations/github/6.7.0/docs/data-sources/repositories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_enterprise_slug"></a> [github\_enterprise\_slug](#input\_github\_enterprise\_slug) | The slug of the GitHub Enterprise where resources will be created.<br/><br/>  This is needed by the GitHub Enterprise Terraform provider.<br/><br/>  This can be set via either;<br/><br/>  - TF\_VAR\_github\_enterprise\_slug environment variable.<br/>  - github\_enterprise\_slug variable in the terraform.tfvars file. | `string` | n/a | yes |
| <a name="input_github_managed_repositories"></a> [github\_managed\_repositories](#input\_github\_managed\_repositories) | List of repository names that are managed by Terraform. Passed from the repos module output. | `list(string)` | `[]` | no |
| <a name="input_github_organization_name"></a> [github\_organization\_name](#input\_github\_organization\_name) | Required. The name of the GitHub organization to create the team in. | `string` | n/a | yes |
| <a name="input_github_projects"></a> [github\_projects](#input\_github\_projects) | List of GitHub Project configuration objects. | <pre>list(object({<br/>    # Project<br/>    name       = string<br/>    type       = optional(string)<br/>    body       = optional(string)<br/>    repository = optional(string)<br/><br/>    # Project Columns<br/>    columns = optional(list(object({<br/>      name = string<br/>    })), [])<br/><br/>    # Project Cards<br/>    cards = optional(list(object({<br/>      column_name  = string<br/>      content_type = optional(string)<br/>      content_id   = optional(string)<br/>      note         = optional(string)<br/>    })), [])<br/>  }))</pre> | `[]` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
