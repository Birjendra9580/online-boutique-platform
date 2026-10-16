variable "project_id" {
  description = "project id where the all resources will be created"
  type        = string
}

variable "region" {
  description = "resource location"
  type        = string
  default     = "asia-south1"
}

variable "zone" {
  type    = string
  default = "asia-south1-a"
}

variable "bucket_suffix" {
  description = "unique lowercase for bucket"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{2,19}$", var.bucket_suffix))
    error_message = "bucket_suffix must contain 3-20 lowercase letters, digits, or hyphens and must start with a letter or digit."
  }
}