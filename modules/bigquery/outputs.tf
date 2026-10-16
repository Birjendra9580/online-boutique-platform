output "dataset_ids" {
    description = "Created big query dataset ids"

    value = {
        for key, dataset in google_bigquery_dataset.bigquery :
        key => dataset.dataset_id
    }
}

output "dataset_locations" {
    description = "Locations of created datasets"

    value = {
        for key, dataset in google_bigquery_dataset.bigquery :
        key => dataset.location
    }
}

output "dataset_project-ids" {
    description = "GCP project id containg the dataset"

    value = {
        for key, dataset in google_bigquery_dataset.bigquery :
        key => dataset.project
    }
  
}