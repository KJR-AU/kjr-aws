output "user_ids" {
  value       = { for email, user in aws_identitystore_user.users : email => user.user_id }
  description = "Identity Store user IDs keyed by email."
}
