variable "project_id" {
    description = "GCP project id"
    type = string
}

variable "datasets" {
    description = "Big Query Datasets"
    
    type = map(object({
      location                   = optional(string, "asia-south1")
      description                = optional(string, "")
      delete_contents_on_destroy = optional(bool, false)
      max_time_travel_hours      = optional(number, 168)
      labels                     = optional(map(string), {})
    }))

    default = {}

    validation {
      condition = alltrue([
        for dataset in values(var.datasets) :
        dataset.max_time_travel_hours >= 48 &&
        dataset.max_time_travel_hours <= 168 &&
        dataset.max_time_travel_hours % 24 == 0
      ])
      error_message = "max_time_travel_hours must be 48 through 168 in increments of 24."
    }
}


