# Artifact Registry Module

Creates GCP Artifact Registry Docker repositories.

## Features

- Supports multiple repositories using 'for_each'.
- Allows repository-specific locations and descriptions.
- Supports immutable image tags.
- Supports labels.

## Notes

- Enable the Artifact Registry API before creating repositories.
- Configure IAM permissions separately.
- Use unique image tags for CI/CD deployments.
- Immutable tags prevent an existing tag from being overwritten.
- Verify that the chosen location is appropriate for the workload.