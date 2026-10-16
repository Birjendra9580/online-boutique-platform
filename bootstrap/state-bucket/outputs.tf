output "state_bucket_name" {
  description = "Name of the Terraform remote state bucket."
  value       = google_storage_bucket.terraform_state.name
}

output "state_bucket_url" {
  description = "URL of the Google Storage bucket used for Terraform remote state."
  value       = "gs://${google_storage_bucket.terraform_state.name}"
}

output "state_bucket_location" {
  description = "Location of the Terraform remote state bucket."
  value       = google_storage_bucket.terraform_state.location
}
