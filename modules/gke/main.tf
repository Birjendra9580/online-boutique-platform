locals {
    node_pools = {
        for item in flatten([
            for cluster_key, cluster in var.clusters : [
                for pool_key, pool in cluster.node_pools : {
                    key         = "${cluster_key}/${pool_key}"
                    cluster_key = cluster_key
                    location    = cluster.location
                    pool        = pool 
                }
            ]
        ]) : item.key => item
    }
}

resource "google_container_cluster" "cluster" {
    for_each = var.clusters

    project    = var.project_id
    name       = each.value.name
    location   = each.value.location
    network    = var.network_self_link[each.value.network_key]
    subnetwork = var.subnet_self_link[each.value.subnet_key]

    release_channel {
      channel = each.value.release_channel
    }

    monitoring_config {

        enable_components = ["SYSTEM_COMPONENTS"]

        managed_prometheus {
          enabled = false
        }

    }

    remove_default_node_pool = true
    initial_node_count       = 1
    deletion_protection      = each.value.deletion_protection

    ip_allocation_policy {
      cluster_secondary_range_name = each.value.pods_range_name
      services_secondary_range_name = each.value.services_range_name
    }

    private_cluster_config {
      enable_private_nodes    = each.value.enable_private_nodes
      enable_private_endpoint = each.value.enable_private_endpoint
      master_ipv4_cidr_block  = each.value.master_ipv4_cidr_block
    }
}

resource "google_container_node_pool" "app_node_pool" {
    for_each = local.node_pools

    project            = var.project_id
    name               = each.value.pool.name
    location           = each.value.location
    cluster            = google_container_cluster.cluster[each.value.cluster_key].name
    initial_node_count = each.value.pool.initial_node_count

    autoscaling {
      min_node_count = each.value.pool.min_node_count
      max_node_count = each.value.pool.max_node_count
    }

    management {
      auto_repair  = each.value.pool.auto_repair
      auto_upgrade = each.value.pool.auto_upgrade
    }

    node_config {
      machine_type    = each.value.pool.machine_type 
      disk_size_gb    = each.value.pool.disk_size_gb
      disk_type       = each.value.pool.disk_type 
      service_account = each.value.pool.service_account_email

      oauth_scopes = [
        "https://www.googleapis.com/auth/cloud-platform"
      ]

      labels = each.value.pool.labels
    }
}