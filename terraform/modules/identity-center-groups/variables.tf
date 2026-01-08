variable "identity_store_id" {
  type        = string
  description = "Identity Store ID for the Identity Center instance."
}

variable "sso_instance_arn" {
  type        = string
  description = "Identity Center instance ARN (arn:aws:sso:::instance/ssoins-xxxxxxxxxxxxxxxx)."
}

variable "accounts" {
  type = list(
    object({
      name = string
      id   = string
    })
  )
  description = "List of AWS accounts to provision Identity Center groups and assignments for."
}

variable "role_definitions" {
  type = map(object({
    suffix             = string
    permission_set_arn = string
  }))
  description = "Map of role definitions to create per account. Keys are identifiers; values provide name suffix and Identity Center permission set ARN."
}
