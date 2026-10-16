variable "project_id" {
    type = string
}

variable "service_accounts" {
    description = "services accounts"

    type = map(object({
      account_id   = string
      display_name = string
      description  = optional(string, "") 
    }))

    default = {} 
}

variable "project_role_bindings" {
    description = "project iam roles"

    type = map(object({
      service_account_key = string
      role                = string 
    }))

    default = {}

    validation {
      condition = alltrue([
        for binding in values(var.project_role_bindings) :
        length(trimspace(binding.role)) > 0
      ])

      error_message = "Every project role binding must specify a role."
    }
}

