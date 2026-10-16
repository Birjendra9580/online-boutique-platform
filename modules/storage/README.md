# Storage Module

Creates Cloud Storage buckets using Terraform for_each.

## Features

- Multiple buckets
- Configurable locations and storage classes
- Object versioning
- Uniform bucket-level access
- Public access prevention
- Labels
- Protection against accidental destruction

## Notes

- Bucket names must be globally unique.
- Do not enable public access unless explicitly required.
- force_destroy defaults to false.
- prevent_destroy blocks Terraform from destroying these buckets.
- Configure lifecycle rules separately for object transitions and expiration.
- Manage bucket IAM permissions using least privilege.
- Keep the Terraform state bucket separate from application storage.