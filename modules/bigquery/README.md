# BigQuery Module

Creates BigQuery datasets using 'for_each'.

## Features

- Multiple datasets
- Configurable locations and descriptions
- Dataset labels
- Configurable time-travel retention
- Protection against accidental destruction

## Notes

- Dataset IDs must be unique within a project.
- Dataset locations must be compatible with the data and services using them.
- Tables and schemas are managed separately.
- Existing datasets must be imported into Terraform state before Terraform manages them.
- 'prevent_destroy = true' intentionally blocks dataset destruction.