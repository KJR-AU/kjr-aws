terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46.0"
    }
  }

  backend "s3" {
    region  = "ap-southeast-2"
    profile = "mgmt-admin"
    bucket = "kjr-terraform"
    key = "state/kjr-aws/terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
  profile = "mgmt-admin"
}

module "identity_center_groups" {
  source = "./modules/identity-center-groups"

  identity_store_id = var.identity_store_id
  sso_instance_arn  = var.sso_instance_arn
  accounts          = var.accounts
  role_definitions  = var.role_definitions
}

output "group_names" {
  value       = module.identity_center_groups.group_names
  description = "Identity Center groups created for each account role."
}

output "permission_sets" {
  value       = module.identity_center_groups.permission_sets
  description = "Permission set ARNs keyed by account-role."
}
