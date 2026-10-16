variable "project_id" {
  description = "The GCP project id, where the state bucket will be created."
  type        = string
}

variable "region" {
  description = "GCP region, where the state bucket will be created."
  type        = string
}

variable "state_bucket_name" {
  description = "bucket name for storing the terraform state file."
  type        = string

  validation {
    condition     = length(var.state_bucket_name) >= 3 && length(var.state_bucket_name) <= 63
    error_message = "The bucket name must be between 3 and 63 characters."
  }
}

variable "labels" {
  description = "Labels to apply to the state bucket."
  type        = map(string)

  default = {
    managed-by  = "terraform"
    environment = "shared"
    purpose     = "terraform-state"
  }
}



