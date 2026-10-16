output "cluster_names" {
    description = "Created GKE cluster names."

    value = {
        for key, cluster in google_container_cluster.cluster :
        key => cluster.name
    } 
}

output "cluster_locations" {
    description = "Locations of GKE clusters."

    value = {
        for key, cluster in google_container_cluster.cluster :
        key => cluster.location
    }
}

output "cluster_endpoint" {
    description = "GKE API endpoint"

    value = {
        for key, cluster in google_container_cluster.cluster :
        key => cluster.endpoint
    }

    sensitive = true
}

output "node_pool_names" {
    description = "created node pool name"

    value = {
        for key, pool in google_container_node_pool.app_node_pool :
        key => pool.name
    }
}