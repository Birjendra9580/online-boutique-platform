resource "google_bigquery_dataset" "bigquery" {
    for_each = var.datasets

    project                    = var.project_id
    dataset_id                 = each.key
    location                   = each.value.location
    description                = each.value.description
    delete_contents_on_destroy = each.value.delete_contents_on_destroy
    max_time_travel_hours      = each.value.max_time_travel_hours
    labels                     = each.value.labels

    lifecycle {
      prevent_destroy = true
    }
}