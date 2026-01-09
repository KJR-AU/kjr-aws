region            = "ap-southeast-2"
identity_store_id = "d-9767aeefa5"
sso_instance_arn  = "arn:aws:sso:::instance/ssoins-8259455dfb1ca5b1"

role_definitions = {
  admins = {
    suffix             = "admins"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-8259455dfb1ca5b1/ps-8259ec197874d6d7"
  }
  power-users = {
    suffix             = "power-users"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-8259455dfb1ca5b1/ps-82591ed25393ee1b"
  }
  read-only = {
    suffix             = "read-only"
    permission_set_arn = "arn:aws:sso:::permissionSet/ssoins-8259455dfb1ca5b1/ps-825990ba7cbe8930"
  }
}