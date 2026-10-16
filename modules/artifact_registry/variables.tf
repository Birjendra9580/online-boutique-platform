variable "project_id" {
  description = "The GCP project id. Where the artifact registry will be created."
  type        = string
}

variable "repositories" {
  description = "The GCP repositories."
  
  type        = map(object({
    description    = optional(string, "")
    location       = optional(string, "asia-south1")
    immutable_tags = optional(bool, true)
    labels         = optional(map(string), {})
  }))

  default = {}
}

