# IAM Module

Creates GCP service accounts and grants project-level IAM roles.

## Features

- Multiple service accounts
- Multiple project-level role bindings
- Reusable logical keys
- IAM member resources that avoid replacing unrelated members

## Notes

- Use least-privilege IAM roles.
- Avoid Owner and Editor roles for application service accounts.
- Do not create service account keys unless specifically required.
- Prefer Workload Identity for GKE workloads.
- Each role binding must reference a service account key defined in service_accounts.
- Use resource-level IAM when project-level permissions are too broad.