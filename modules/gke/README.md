# GKE Module

Creates GKE clusters and node pools.

## Features

- Multiple clusters
- Multiple node pools per cluster
- Private node configuration
- VPC-native networking
- Configurable release channels
- Node pool autoscaling
- Automatic repair and upgrades

## Requirements

- VPC and subnet must exist.
- The subnet must contain the configured Pod and Service secondary ranges.
- The node service account must exist.
- Required GCP APIs must be enabled.
- The chosen machine type must be available in the selected location.

## Notes

- Private nodes may require Cloud NAT for outbound internet access.
- Private control-plane endpoints require suitable administrative connectivity.
- Configure IAM permissions using least privilege.
- Review node pool limits to control costs.
- Validate the configuration with the selected Google provider version before applying.