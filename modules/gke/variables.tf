variable "project_id" {
    type = string
}

variable "network_self_link" {
    description = "vpc self link"
    type        = map(string)
}

variable "subnet_self_link" {
    description = "subnet self link"
    type        = map(string)
}

variable "clusters" {
    description = "GKE cluster and their node pools"

    type = map(object({

       name                = string
       location            = string
       network_key         = string
       subnet_key          = string
       pods_range_name     = string
       services_range_name = string 

       release_channel         = optional(string, "REGULAR")
       deletion_protection     = optional(bool, true)
       enable_private_nodes    = optional(bool, true)
       enable_private_endpoint = optional(bool, false)
       master_ipv4_cidr_block  = optional(string, "172.16.0.0/28")

       node_pools = map(object({

        name                  = string
        machine_type          = string
        service_account_email = string

        initial_node_count  = optional(number, 1)
        disk_size_gb        = optional(number, 50)
        disk_type           = optional(string, "pd-balanced")
        autoscaling_enabled = optional(bool, true)
        min_node_count      = optional(number, 1)
        max_node_count      = optional(number, 3)
        auto_repair         = optional(bool, true)
        auto_upgrade        = optional(bool, true)
        labels              = optional(map(string), {})
       }))

    }))

    default = {}

    validation {
      condition = alltrue([
        for cluster in values(var.clusters) :
        contains(
            ["RAPID", "REGULAR", "STABLE", "EXTENDED"],
            cluster.release_channel
        )
      ])

      error_message = "release_channel must be rapid, regular, stable or extended."

    } 
}