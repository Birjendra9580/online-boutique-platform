# Network Module

This module creates reusable GCP networking resources.

## Resources

- VPC networks
- Subnets
- Secondary subnet IP ranges
- Ingress firewall rules
- Egress firewall rules

## Design

Resources use `for_each`, allowing multiple VPCs, subnets, and firewall rules
to be created from maps.

## Important Notes

- Each subnet and firewall rule references a logical key from the `networks` map.
- Subnet CIDR ranges must not overlap with conflicting ranges in the network.
- Secondary IP ranges are useful for GKE Pod and Service ranges.
- Private Google Access allows supported private workloads to access Google APIs.
- Firewall rules should follow least-privilege principles.
- Do not expose SSH, RDP, or application ports to `0.0.0.0/0` without a justified requirement.
- This module does not create Cloud NAT, VPNs, or load balancers.

## Example

A subnet can reference a network using its logical key:

`network = "dev_vpc"`

The corresponding entry must exist in the `networks` map.