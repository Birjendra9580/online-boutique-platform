# Compute Module

Creates Compute Engine VMs using Terraform 'for_each'.

## Features

- Multiple VMs
- Configurable machine type and zone
- Configurable boot disk
- Subnet selection through a logical key
- Optional external IP
- Optional service account
- Network tags and labels

## Notes

- The referenced subnet must already exist.
- Set assign_public_ip to false unless an external IP is required.
- Configure firewall rules separately.
- Private VMs may need Cloud NAT for outbound internet access.
- Service accounts should have only the permissions they require.
- Do not store passwords, tokens, or private keys in VM metadata.