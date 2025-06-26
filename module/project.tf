# Organization Projects
# The organization must already exist.
resource "github_organization_project" "this" {
  for_each = {
    for project in var.github_projects :
    project.name => project
    if project.type == "organization"
  }

  name = each.value.name
  body = each.value.body

  depends_on = [
    data.github_organization.this
  ]
}

# Repository Projects
# The repository must already exist.
resource "github_repository_project" "this" {
  for_each = {
    for project in var.github_projects :
    project.name => project
    if project.type == "repository"
  }

  name       = each.value.name
  repository = each.value.repository
  body       = each.value.body

  depends_on = [
    data.github_organization.this,
    data.github_repositories.this
  ]
}
