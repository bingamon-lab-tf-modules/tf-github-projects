# Project Cards
resource "github_project_card" "this" {
  for_each = {
    for card in local.all_cards :
    card.key => card
    if card.is_valid
  }

  column_id = local.column_id_map["${each.value.project_name}:${each.value.column_name}"]

  # Type: Note
  note = each.value.note

  # Type: Content
  content_id   = each.value.content_id
  content_type = each.value.content_type

  depends_on = [
    github_project_column.organization,
    github_project_column.repository
  ]
}