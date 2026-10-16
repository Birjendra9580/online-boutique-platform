# Vertex AI Module

Creates Vertex AI endpoints using Terraform for_each.

## Features

- Multiple endpoints
- Configurable endpoint names and regions
- Descriptions and labels

## Notes

- Enable the Vertex AI API before creating endpoints.
- Confirm that the selected region supports the intended workload.
- Creating an endpoint does not deploy a model.
- Model training, model registration, deployment, and prediction workflows are separate.
- Review endpoint and deployed-model costs before sending production traffic.
- Configure IAM permissions using least privilege.