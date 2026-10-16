# Online Boutique - Dev Infrastructure

Terraform configuration for the Dev environment of the Online Boutique
application and MLOps project.

## Cloud Provider

Google Cloud Platform.

## Region

asia-south1 (Mumbai).

## GKE Location

asia-south1-a.

The initial configuration uses a zonal GKE cluster.

## Modules

- Network
- IAM
- Artifact Registry
- Storage
- BigQuery
- Compute Engine
- GKE
- Vertex AI

## Resources Configured

- Custom VPC and subnet
- GKE Pod and Service secondary IP ranges
- GKE node service account
- CI/CD service account
- Project-level IAM role bindings
- Artifact Registry Docker repositories
- Application Cloud Storage bucket
- BigQuery dataset
- GKE cluster and node pool

The Compute Engine module is connected but has no VM instances configured.

The Vertex AI module is connected but has no endpoints configured.

## Terraform State

The remote backend uses the existing Cloud Storage bucket:

state15890-terraform-state

State prefix:

online-boutique/dev

The state bucket is managed separately from the application storage module.

## Deployment Workflow

1. Confirm the project ID and permissions.
2. Initialize Terraform with the GCS backend.
3. Validate the configuration.
4. Generate and review a Terraform plan.
5. Apply only after confirming the planned changes.

## Security

- GKE worker nodes use private IP addresses.
- Private Google Access is enabled on the subnet.
- Application bucket public access prevention is enabled.
- Service accounts should follow least-privilege IAM.
- CI/CD deployment permissions must be configured separately.
- No service account keys should be committed to Git.

## Cost Management

GKE, node VMs, persistent disks, storage, network traffic, and other
Google Cloud resources can incur charges.

Review the plan and expected costs before creating resources.