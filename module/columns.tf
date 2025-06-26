# Organization Project Columns
resource "github_project_column" "organization" {
  for_each = {
    for column in local.all_columns :
    column.key => column
    if column.project_type == "organization"
  }

  project_id = github_organization_project.this[each.value.project_name].id
  name       = each.value.column_name

  depends_on = [
    github_organization_project.this
  ]
}

# Repository Project Columns
resource "github_project_column" "repository" {
  for_each = {
    for column in local.all_columns :
    column.key => column
    if column.project_type == "repository"
  }

  project_id = github_repository_project.this[each.value.project_name].id
  name       = each.value.column_name

  depends_on = [
    github_repository_project.this
  ]
}

# Create a map of column keys to IDs for lookup later.
locals {
  column_id_map = merge(
    {
      for key, col in github_project_column.organization : key => col.id
    },
    {
      for key, col in github_project_column.repository : key => col.id
    }
  )
}
