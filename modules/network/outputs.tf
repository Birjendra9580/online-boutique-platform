output "network_ids" {
    description = "Id's of created vpc networks."

    value = {
        for key, network in google_compute_network.vpc_network : key => network.id
    }
}

output "network_names" {
    description = "Names of created vpc networks."

    value = {
        for key, network in google_compute_network.vpc_network : key => network.name
    }
}

output "network_self_links" {
    description = "Self links of created vpc networks."

    value = {
        for key, network in google_compute_network.vpc_network : key => network.self_link
    }
}

output "subnet_ids" {
    description = "Id's of created subnets."

    value = {
        for key, subnet in google_compute_subnetwork.subnet : key => subnet.id
    }
}

output "subnet_self_links" {
    description = "Self links of created subnets."

    value = {
        for key, subnet in google_compute_subnetwork.subnet : key => subnet.self_link
    }
}

output "firewall_rule_names" {
    description = "Names of created firewall rules."

    value = {
        for key, rule in google_compute_firewall.firewall_rule : key => rule.name
    }
}