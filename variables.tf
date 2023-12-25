variable "name" {
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name))
    error_message = "The name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "location" {
  type        = string
  default     = "West Europe"
}

variable "environment" {
  type        = string
  default     = "development"
}

variable "container_names" {
  type    = list(string)
}

variable "resource_group_name" {
  type = string
}

variable "rbac" {
  type = list(object({
    identity_name = string
    identity_resource_group = string
    container_name = string
    role = string
  }))
  description = "Identity names mapped to container names which are mapped to the associated role."
}


# variable "acl" {
#   type    = list(object({
#     identityName = string
#     containers = list(object({
#       name = string
#       role = string
#     }))
#   }))
# }
