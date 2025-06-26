# Assert that all repository projects reference existing repositories
check "repository_validation" {
  assert {
    condition = length(local.invalid_repository_projects) == 0
    error_message = <<-EOT
      Repository validation failed for organization '${var.github_organization_name}'.

      ${length(local.invalid_repository_projects) > 0 ?
    "Invalid repository references found:\n${join("\n", [
      for project in local.invalid_repository_projects :
      "- Project '${project.name}' references repository '${project.repository}' which does not exist"
    ])}" : ""
    }

      Available repositories:

      - Managed by Terraform: ${length(local.managed_repo_names) > 0 ? join(", ", sort(local.managed_repo_names)) : "None (repositories may not be created yet)"}
      - Existing in GitHub: ${length(local.existing_repositories) > 0 ? join(", ", sort(local.existing_repositories)) : "None"}

      ${length(local.all_available_repositories) == 0 ?
    "Note: No repositories are available for validation. This may be normal during initial plan if repositories haven't been created yet." :
    "If the repository should exist:\n1. Check for typos in the repository name\n2. Ensure the repository is defined in repositories.yaml\n3. Verify the repository exists in the GitHub organization"
  }

      Please check your project configurations and ensure all repository references are correct.
    EOT
}
}

# Assert that all cards are valid across all projects
check "card_validation" {
  assert {
    condition = length(local.invalid_cards) == 0
    error_message = <<-EOT
      Invalid card configuration found. Each card must have either:
      - A note
      - OR both content_id and content_type

      Invalid cards found:
      ${join("\n", [
    for card in local.invalid_cards :
    "- Project '${card.project_name}', Card ${card.card_index}: note=${card.has_note ? "present" : "missing"}, content=${card.has_content ? "present" : "missing"}"
    ])}

      Card configurations:
      ${jsonencode([
    for card in local.invalid_cards : {
      project     = card.project_name
      card_index  = card.card_index
      has_note    = card.has_note
      has_content = card.has_content
    }
])}
    EOT
}

assert {
  condition = length(local.invalid_column_cards) == 0
  error_message = <<-EOT
      Invalid column names found in cards. The following cards reference non-existent columns:

      ${join("\n", [
  for card in local.invalid_column_cards :
  "- Project '${card.project_name}', Card ${card.card_index}: references column '${card.column_name}' which does not exist"
  ])}

      Available columns by project:
      ${join("\n", [
  for project_name, columns in local.valid_column_names_by_project :
  "- ${project_name}: ${join(", ", columns)}"
])}
    EOT
}
}
