output "project_id" {
  description = "GCP project ID."
  value       = var.project_id
}

output "region" {
  description = "GCP region."
  value       = var.region
}

output "network_names" {
  description = "VPC network names."
  value       = module.network.network_names
}

output "network_self_links" {
  description = "VPC self-links."
  value       = module.network.network_self_links
}

output "subnet_self_links" {
  description = "Subnet self-links."
  value       = module.network.subnet_self_links
}

output "artifact_registry_urls" {
  description = "Artifact Registry repository URLs."
  value       = module.artifact_registry.repository_urls
}

output "application_bucket_names" {
  description = "Application Cloud Storage bucket names."
  value       = module.storage.bucket_names
}

output "bigquery_dataset_ids" {
  description = "BigQuery dataset IDs."
  value       = module.bigquery.dataset_ids
}

output "service_account_emails" {
  description = "Service account email addresses."
  value       = module.iam.service_account_emails
}

output "gke_cluster_names" {
  description = "GKE cluster names."
  value       = module.gke.cluster_names
}

output "gke_cluster_locations" {
  description = "GKE cluster locations."
  value       = module.gke.cluster_locations
}

output "gke_cluster_endpoints" {
  description = "GKE cluster API endpoints."
  value       = module.gke.cluster_endpoint
  sensitive   = true
}

output "compute_instance_names" {
  description = "Compute Engine VM names."
  value       = module.compute.instance_name
}

output "vertex_ai_endpoint_ids" {
  description = "Vertex AI endpoint resource names."
  value       = module.vertex_ai.endpoint_ids
}