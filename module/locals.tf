locals {
  # Flatten all columns across all projects
  all_columns = flatten([
    for project in var.github_projects : [
      for column in(project.columns != null ? project.columns : []) : {
        key          = "${project.name}:${column.name}"
        project_name = project.name
        column_name  = column.name
        project_type = project.type
      }
    ]
  ])

  # Flatten all cards across all projects
  all_cards = flatten([
    for project in var.github_projects : [
      for idx, card in(project.cards != null ? project.cards : []) : {
        key          = "${project.name}:${idx}"
        project_name = project.name
        card_index   = idx
        column_name  = card.column_name
        note         = card.note
        content_id   = card.content_id
        content_type = card.content_type
        has_note     = card.note != null
        has_content  = card.content_id != null && card.content_type != null
        is_valid     = card.note != null || (card.content_id != null && card.content_type != null)
      }
    ]
  ])

  # Get existing repository names from the organization
  # Use try() to handle cases where the organization might not exist yet
  existing_repositories = toset(try(data.github_repositories.this.names, []))

  # Handle managed repositories - ensure we always have a list
  managed_repo_names = try(var.github_managed_repositories, [])

  # Combine managed repositories (from Terraform) with existing repositories (from GitHub)
  all_available_repositories = toset(concat(
    local.managed_repo_names,
    tolist(local.existing_repositories)
  ))

  # Get repository projects that have valid repository names
  repository_projects_with_repos = [
    for project in var.github_projects : {
      name       = project.name
      repository = project.repository
    }
    if project.type == "repository" &&
    project.repository != null &&
    project.repository != ""
  ]

  # Find repository projects that reference non-existent repositories
  # Only check against available repositories if we have any
  invalid_repository_projects = length(local.all_available_repositories) > 0 ? [
    for project in local.repository_projects_with_repos : project
    if !contains(local.all_available_repositories, project.repository)
  ] : []

  # Validate that each card has either a note or both content_id and content_type
  card_validations = [
    for card in local.all_cards : {
      key          = card.key
      project_name = card.project_name
      card_index   = card.card_index
      has_note     = card.has_note
      has_content  = card.has_content
      is_valid     = card.is_valid
    }
  ]

  # Find any invalid cards
  invalid_cards = [
    for validation in local.card_validations :
    validation if !validation.is_valid
  ]

  # Get all valid column names per project
  valid_column_names_by_project = {
    for project in var.github_projects :
    project.name => toset([
      for col in(project.columns != null ? project.columns : []) : col.name
    ])
  }

  # Find cards with invalid column names
  invalid_column_cards = [
    for card in local.all_cards : {
      key          = card.key
      project_name = card.project_name
      card_index   = card.card_index
      column_name  = card.column_name
    } if !contains(local.valid_column_names_by_project[card.project_name], card.column_name)
  ]
}
