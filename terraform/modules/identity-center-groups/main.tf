locals {
  group_plan = {
    for combo in flatten([
      for account in var.accounts : [
        for role in values(var.role_definitions) : {
          key                = "${account.name}-${role.suffix}"
          display_name       = "${account.name}-${role.suffix}"
          account_id         = account.id
          permission_set_arn = role.permission_set_arn
        }
      ]
    ]) : combo.key => combo
  }
}

resource "aws_identitystore_group" "groups" {
  for_each = local.group_plan

  identity_store_id = var.identity_store_id
  display_name      = each.value.display_name
  description       = "Identity Center access group for ${each.value.display_name}"
}

resource "aws_ssoadmin_account_assignment" "assignments" {
  for_each = local.group_plan

  instance_arn       = var.sso_instance_arn
  permission_set_arn = each.value.permission_set_arn
  # aws_identitystore_group.id includes the identity store ID; account assignments expect only the group GUID.
  principal_id   = trimprefix(aws_identitystore_group.groups[each.key].id, "${var.identity_store_id}/")
  principal_type = "GROUP"
  target_id      = each.value.account_id
  target_type    = "AWS_ACCOUNT"
}
