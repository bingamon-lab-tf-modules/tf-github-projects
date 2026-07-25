# tf-github-projects

> [!WARNING]
> **This module is deprecated and non-functional. Do not depend on it.**
>
> GitHub has removed the REST API endpoints for classic Projects, so the resources this module
> builds on no longer work against the live API.
>
> All four resources are marked deprecated in the `integrations/github` provider v6.13.0 with the
> message _"This resource is deprecated as the API endpoints for classic projects have been removed.
> This resource no longer works and will be removed in a future version."_ The resources are
> `github_organization_project`, `github_repository_project`, `github_project_column` and
> `github_project_card`.
>
> **There is no ProjectsV2 replacement in the `integrations/github` provider** as of v6.13.0.
> ProjectsV2 is GraphQL-only and the provider has no equivalent resources, so there is no migration
> path to point you at.
>
> This repository will be **archived**. It may be unarchived if provider support for Projects V2
> ever ships.
>
> In the `lz-github` landing zone this module is already dormant — its configuration file ships as
> `projects.yaml.disabled` — and project boards and issues are managed out of band by
> `lz-cli github-issues`.

## Overview

A Terraform Module for GitHub Projects.

The [Terraform Module](module/README.md) documentation contains the available variables and outputs.
