locals {
  # Accept the key as a real PEM, a single-line PEM (newlines collapsed to spaces
  # by a secret store), or a PEM with literal "\n" sequences. Strip the armor and
  # whitespace, then rebuild a PEM the provider can parse.
  private_key_body = replace(var.snowflake_private_key, "/-----[A-Z ]+-----|\\s|\\\\n/", "")
  private_key      = "-----BEGIN PRIVATE KEY-----\n${local.private_key_body}\n-----END PRIVATE KEY-----\n"
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
