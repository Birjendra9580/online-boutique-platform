resource "google_vertex_ai_endpoint" "vertex_ai" {
    for_each = var.endpoints

    project = var.project_id
    name = each.value.display_name
    display_name = each.value.display_name
    location = each.value.region
    description = each.value.description
    labels = each.value.labels
  
}