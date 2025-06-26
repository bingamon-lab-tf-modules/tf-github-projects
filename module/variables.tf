variable "github_enterprise_slug" {
  type        = string
  description = <<EOT
  The slug of the GitHub Enterprise where resources will be created.

  This is needed by the GitHub Enterprise Terraform provider.

  This can be set via either;

  - TF_VAR_github_enterprise_slug environment variable.
  - github_enterprise_slug variable in the terraform.tfvars file.
  EOT
}

variable "github_organization_name" {
  type        = string
  description = "Required. The name of the GitHub organization to create the team in."
}

variable "github_managed_repositories" {
  type        = list(string)
  description = "List of repository names that are managed by Terraform. Passed from the repos module output."
  default     = []
}

variable "github_projects" {
  description = "List of GitHub Project configuration objects."
  type = list(object({
    # Project
    name       = string
    type       = optional(string)
    body       = optional(string)
    repository = optional(string)

    # Project Columns
    columns = optional(list(object({
      name = string
    })), [])

    # Project Cards
    cards = optional(list(object({
      column_name  = string
      content_type = optional(string)
      content_id   = optional(string)
      note         = optional(string)
    })), [])
  }))
  default = []

  validation {
    condition = alltrue([
      for project in var.github_projects : project.name != null && project.name != ""
    ])
    error_message = <<EOT
    ❌ Project validation has failed.

    All projects must have a non-empty 'name' field.

    Please check your project configuration and ensure every project has a valid name.
    EOT
  }

  validation {
    condition = alltrue([
      for project in var.github_projects : project.type == "organization" || project.type == "repository"
    ])
    error_message = <<EOT
    ❌ Project validation has failed.

    All projects must have a type of "organization" or "repository".

    Projects with invalid types:
    ${join("\n", [
    for project in var.github_projects :
    "- Project '${project.name}' has invalid type '${project.type}'"
    if project.type != "organization" && project.type != "repository"
])}

    Please check your project configurations and ensure every project has a valid type.
    EOT
}

validation {
  condition = alltrue([
    for project in var.github_projects :
    project.type != "repository" || (project.repository != null && project.repository != "")
  ])
  error_message = <<EOT
    ❌ Repository project validation has failed.

    All repository-type projects must have a non-empty 'repository' field.

    Repository projects missing repository field:
    ${join("\n", [
  for project in var.github_projects :
  "- Project '${project.name}' (type: ${project.type}) is missing repository field"
  if project.type == "repository" && (project.repository == null || project.repository == "")
])}

    Please check your project configurations and ensure all repository projects specify a repository.
    EOT
}
}
