variable "project_id" {
    type = string
}

variable "buckets" {
    description = "Cloud storage bucket"

    type = map(object({
      name                        = string
      location                    = optional(string, "ASIA-SOUTH1")
      storage_class               = optional(string, "STANDARD")
      versioning_enabled          = optional(bool, true)
      uniform_bucket_level_access = optional(bool, true)
      public_access_prevention    = optional(string, "enforced")
      labels                      = optional(map(string), {})
      force_destroy               = optional(bool, false)
    }))

    default = {}

    validation {
      condition = alltrue([
        for bucket in values(var.buckets) :
        contains(
            ["STANDARD", "NEARLINE", "COLDLINE", "ARCHIVE"],
            bucket.storage_class
        )
      ])

      error_message = "valuestorage_class must be STANDARD, NEARLINE, COLDLINE, or ARCHIVE."
    }
}