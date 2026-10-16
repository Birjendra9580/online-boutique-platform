variable "project_id" {
    type = string 
}

variable "endpoints" {
    description = "Vertex AI endpoints"

    type = map(object({
      desplay_name = string
      region = optional(string, "asia-south1")
      description = optional(string, "")
      labels = optional(map(string), {})
    }))

    default = {} 
}