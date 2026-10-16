resource "google_artifact_registry_repository" "artifact_registry" {
    for_each = var.repositories
    
    project     = var.project_id
    location    = each.value.location
    repository_id = each.key
    description = each.value.description
    format      = "DOCKER"
    labels      = each.value.labels
    
    docker_config {
        immutable_tags = each.value.immutable_tags
    }
}