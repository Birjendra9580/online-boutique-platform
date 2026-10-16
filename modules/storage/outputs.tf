output "bucket_names" {
    description = "created bucket name"

    value = {
        for key, bucket in google_storage_bucket.GCS :
        key => bucket.name
    }
}

output "bucket_urls" {
    description = "GCP bucket url"

    value = {
        for key, bucket in google_storage_bucket.GCS :
        key => "gs://${bucket.name}"
    }
}

output "bucket_location" {
    description = "location of created bucket"

    value = {
        for key, bucket in google_storage_bucket.GCS :
        key => bucket.location
    }
}