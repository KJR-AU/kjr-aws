variable "region" {
  type        = string
  description = "AWS region for Identity Center administration (must match the Identity Center home region)."
}

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
  default = {
    admins = {
      suffix             = "admins"
      permission_set_arn = "arn:aws:sso:::permissionSet/aws-managed/AWSAdministratorAccess"
    }
    power-users = {
      suffix             = "power-users"
      permission_set_arn = "arn:aws:sso:::permissionSet/aws-managed/AWSPowerUserAccess"
    }
    read-only = {
      suffix             = "read-only"
      permission_set_arn = "arn:aws:sso:::permissionSet/aws-managed/AWSReadOnlyAccess"
    }
  }
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
  default     = []
}
