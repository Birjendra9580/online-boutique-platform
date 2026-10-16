variable "project_id" {
  description = "The GCP project id, where the network resources will be created."
  type        = string
}

variable "region" {
  description = "GCP region, where the network resources will be created."
  type        = string
}

variable "networks" {
  description = "Name of the VPC network."
  
  type        = map(object({
    name                    = string
    description             = optional(string, null)
    auto_create_subnetworks = optional(bool, false)
    routing_mode            = optional(string, "REGIONAL")
  }))

  default = {}

  validation {
    condition     = alltrue([for network in values(var.networks) : contains(["REGIONAL", "GLOBAL"], network.routing_mode) ])
    error_message = "The routing_mode must be either 'REGIONAL' or 'GLOBAL'."
  }
}


variable "subnets" {
  description = "Name of the subnetworks."
  
  type        = map(object({
    name          = string
    network       = string
    ip_cidr_range = string
    region        = string
    description   = optional(string, null)
    private_ip_google_access  = optional(bool, true)
    secondary_ip_ranges       = optional(map(string), {})
  }))

  default = {}
}

variable "firewall_rules" {
  description = "Firewall rules to be created in the VPC network."
  
  type        = map(object({
    name               = string
    network            = string
    direction          = optional(string, "INGRESS")
    priority           = optional(number, 1000)
    source_ranges      = optional(list(string), [])
    target_tags        = optional(list(string), [])
    destination_ranges = optional(list(string), [])
    description        = optional(string, null)

    allow      = optional(list(object({
      protocol = string
      ports    = optional(list(string), [])
    })), [])

    deny       = optional(list(object({
      protocol = string
      ports    = optional(list(string), [])
    })), [])
  }))

  default = {}

  validation {
    condition     = alltrue([for rule in values(var.firewall_rules) : length(rule.allow) > 0 || length(rule.deny) > 0 ])
    error_message = "The direction must be either 'INGRESS' or 'EGRESS'."
  }
}

