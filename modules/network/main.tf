resource "google_compute_network" "vpc_network" {
    for_each = var.networks

    name                    = each.value.name
    description             = each.value.description
    auto_create_subnetworks = each.value.auto_create_subnetworks
    project                 = var.project_id
    routing_mode            = each.value.routing_mode
}

resource "google_compute_subnetwork" "subnet" {
    for_each = var.subnets

    name                     = each.value.name
    ip_cidr_range            = each.value.ip_cidr_range
    region                   = each.value.region
    network                  = google_compute_network.vpc_network[each.value.network].id
    private_ip_google_access = each.value.private_ip_google_access
    project                  = var.project_id
    description              = each.value.description

    dynamic "secondary_ip_range" {
        for_each = each.value.secondary_ip_ranges
        content {
            range_name    = secondary_ip_range.key
            ip_cidr_range = secondary_ip_range.value
        }
    }
}

resource "google_compute_firewall" "firewall_rule" {
    for_each = var.firewall_rules

    name         = each.value.name
    network      = google_compute_network.vpc_network[each.value.network].id
    direction    = each.value.direction
    priority     = each.value.priority
    project      = var.project_id
    target_tags  = each.value.target_tags
    description  = each.value.description

    source_ranges = (
        each.value.direction == "INGRESS" ? each.value.source_ranges : null
    )

    destination_ranges = (
        each.value.direction == "EGRESS" ? each.value.destination_ranges : null
    )

    dynamic "allow" {
        for_each = each.value.allow
        content {
            protocol = allow.value.protocol
            ports    = length(allow.value.ports) > 0 ? allow.value.ports : null
        }
    }

    dynamic "deny" {
        for_each = each.value.deny
        content {
            protocol = deny.value.protocol
            ports    = length(deny.value.ports) > 0 ? deny.value.ports : null
        }
    }

}
