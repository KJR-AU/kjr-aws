locals {
  user_map = { for user in var.users : user.email => user }
}

resource "aws_identitystore_user" "users" {
  for_each = local.user_map

  identity_store_id = var.identity_store_id
  user_name         = each.value.email
  display_name      = "${each.value.firstName} ${each.value.lastName}"

  name {
    given_name  = each.value.firstName
    family_name = each.value.lastName
  }

  emails {
    value   = each.value.email
    primary = true
  }
}
