variable "project_id" {
    description = "GCP project id"
    type        = string
}

variable "instances" {
    description = "compute instances"

    type = map(object({
      name         = string
      zone         = string
      machine_type = string
      subnet_key   = string

      boot_disk_size_gb     = optional(number, 20)
      boot_disl_type        = optional(string, "pd-balanced")
      image                 = optional(string, "ubuntu-os-cloud/ubuntu-2404-lts-amd64")
      assign_public_ip      = optional(bool, false)
      tags                  = optional(list(string), [])
      labels                = optional(map(string), {})
      service_account_email = optional(string, null)
      metadata              = optional(map(string), {})
    }))

    default = {}

    validation {
      condition = alltrue([
        for instance in values(var.instances) :
        instance.boot_disk_size_gb >= 10 
      ])
      error_message = "boot_disk_size_gb must be at least 10 GB."
    }
}

variable "subnet_self_links" {
    description = "Map of subnet logical keys to subnet self-links from the network module."
    type        = map(string)
}