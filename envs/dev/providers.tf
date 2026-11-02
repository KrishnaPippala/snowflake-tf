locals {
  private_key = replace(var.snowflake_private_key, "\\n", "\n")
}

provider "snowflake" {
  organization_name      = var.snowflake_organization_name
  account_name           = var.snowflake_account_name
  user                   = var.snowflake_user
  role                   = var.snowflake_role
  authenticator          = "SNOWFLAKE_JWT"
  private_key            = local.private_key
  private_key_passphrase = var.snowflake_private_key_passphrase
}
