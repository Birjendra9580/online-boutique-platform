output "repository_ids" {
    description = "Ids of created artifact registry repositories."

    value = {
        for key, repository in google_artifact_registry_repository.artifact_registry : key => repository.id
    }
}

output "repository_urls" {
    description = "URLs of created artifact repository url."

    value = {
        for key, repository in google_artifact_registry_repository.artifact_registry : 
        key => "${repository.location}-docker.pkg.dev/${var.project_id}/${repository.repository_id}" 
    }
}

output "repository_locations" {
    description = "Locations of created repo"

    value = {
        for key, repository in google_artifact_registry_repository.artifact_registry :
        key => repository.location
    }
  
}