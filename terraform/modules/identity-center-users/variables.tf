variable "identity_store_id" {
  type        = string
  description = "Identity Store ID for the Identity Center instance."
}

variable "users" {
  type = list(
    object({
      email     = string
      firstName = string
      lastName  = string
      assignments = optional(list(object({
        account = string
        role    = string
      })), [])
    })
  )
  description = "List of users to create in the Identity Store."
}

variable "role_definitions" {
  type = map(object({
    suffix             = string
    permission_set_arn = string
  }))
  description = "Role definitions keyed by role identifier (used to derive group keys)."
}

variable "group_ids" {
  type        = map(string)
  description = "Map of account-role group keys to Identity Store group IDs."
}
