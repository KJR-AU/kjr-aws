locals {
  user_map = { for user in var.users : user.email => user }

  assignment_pairs = flatten([
    for user in var.users : [
      for assignment in lookup(user, "assignments", []) : {
        email     = user.email
        group_key = "${assignment.account}-${var.role_definitions[assignment.role].suffix}"
      }
    ]
  ])

  assignment_map = { for a in local.assignment_pairs : "${a.email}/${a.group_key}" => a }
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

resource "aws_identitystore_group_membership" "memberships" {
  for_each = local.assignment_map

  identity_store_id = var.identity_store_id
  group_id          = var.group_ids[each.value.group_key]
  member_id         = aws_identitystore_user.users[each.value.email].user_id
}
