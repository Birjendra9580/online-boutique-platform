resource "google_storage_bucket" "GCS" {
    for_each = var.buckets
    
    project                     = var.project_id
    name                        = each.value.name
    location                    = each.value.location
    storage_class               = each.value.storage_class
    force_destroy               = each.value.force_destroy
    uniform_bucket_level_access = each.value.uniform_bucket_level_access
    public_access_prevention    = each.value.public_access_prevention
    labels                      = each.value.labels 

    versioning {
      enabled = each.value.versioning_enabled
    }
    
    lifecycle {
      prevent_destroy = true
    }
}