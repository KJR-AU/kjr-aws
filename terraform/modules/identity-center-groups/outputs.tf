output "group_names" {
  value       = [for group in aws_identitystore_group.groups : group.display_name]
  description = "Identity Center groups created for each account role."
}

output "permission_sets" {
  value       = { for key, plan in local.group_plan : key => plan.permission_set_arn }
  description = "Permission set ARNs keyed by account-role."
}
