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
    })
  )
  description = "List of users to create in the Identity Store."
}
