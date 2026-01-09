terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46.0"
    }
  }

  backend "s3" {
    bucket = "kjr-terraform"
    key    = "state/kjr-aws/terraform.tfstate"
  }
}

provider "aws" {}

module "identity_center_groups" {
  source = "./modules/identity-center-groups"

  identity_store_id = var.identity_store_id
  sso_instance_arn  = var.sso_instance_arn
  accounts          = var.accounts
  role_definitions  = var.role_definitions
}

module "identity_center_users" {
  source = "./modules/identity-center-users"

  identity_store_id = var.identity_store_id
  users             = var.users
  role_definitions  = var.role_definitions
  group_ids         = module.identity_center_groups.group_ids
}

output "group_names" {
  value       = module.identity_center_groups.group_names
  description = "Identity Center groups created for each account role."
}

output "permission_sets" {
  value       = module.identity_center_groups.permission_sets
  description = "Permission set ARNs keyed by account-role."
}

output "user_ids" {
  value       = module.identity_center_users.user_ids
  description = "Identity Store user IDs keyed by email."
}
