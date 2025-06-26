# Lookup the GitHub Enterprise details.
# tflint-ignore: terraform_unused_declarations
data "github_enterprise" "this" {
  slug = var.github_enterprise_slug
}

# Lookup the GitHub Organization details.
# tflint-ignore: terraform_unused_declarations
data "github_organization" "this" {
  name = var.github_organization_name
}

# GitHub Repositories data
# Used to validate repositories exist before creating projects
# Note: This will fail if the organization doesn't exist yet.
data "github_repositories" "this" {
  query = "org:${var.github_organization_name}"

  depends_on = [
    data.github_organization.this
  ]
}
