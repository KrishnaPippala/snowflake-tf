locals {
  app         = upper(var.app_name)
  environment = upper(var.environment)
  name_prefix = "${local.app}_${local.environment}"
  comment     = "Managed by Terraform for application ${local.app} in ${local.environment}."
  schema_names = toset([
    "RAW",
    "STAGE",
    "CURATED",
    "APP",
  ])
}

resource "snowflake_database" "this" {
  name    = "${local.name_prefix}_DB"
  comment = local.comment

  lifecycle {
    prevent_destroy = true
  }
}

resource "snowflake_schema" "this" {
  for_each = local.schema_names

  database = snowflake_database.this.name
  name     = each.value
  comment  = local.comment
}

resource "snowflake_warehouse" "this" {
  name                = "${local.name_prefix}_WH"
  warehouse_size      = "XSMALL"
  auto_suspend        = 60
  auto_resume         = "true"
  initially_suspended = true
  resource_monitor    = snowflake_resource_monitor.this.name
  comment             = local.comment
}

resource "snowflake_account_role" "owner" {
  name    = "${local.name_prefix}_OWNER"
  comment = local.comment
}

resource "snowflake_account_role" "rw" {
  name    = "${local.name_prefix}_RW"
  comment = local.comment
}

resource "snowflake_account_role" "ro" {
  name    = "${local.name_prefix}_RO"
  comment = local.comment
}

resource "snowflake_grant_account_role" "owner_to_sysadmin" {
  role_name        = snowflake_account_role.owner.name
  parent_role_name = "SYSADMIN"
}

resource "snowflake_grant_account_role" "rw_to_owner" {
  role_name        = snowflake_account_role.rw.name
  parent_role_name = snowflake_account_role.owner.name
}

resource "snowflake_grant_account_role" "ro_to_owner" {
  role_name        = snowflake_account_role.ro.name
  parent_role_name = snowflake_account_role.owner.name
}

resource "snowflake_service_user" "deploy" {
  name              = "${local.name_prefix}_DEPLOY_SVC"
  rsa_public_key    = var.deploy_user_public_key
  default_role      = snowflake_account_role.owner.name
  default_warehouse = snowflake_warehouse.this.name
  default_namespace = snowflake_database.this.name
  comment           = local.comment
}

resource "snowflake_grant_account_role" "owner_to_deploy_user" {
  role_name = snowflake_account_role.owner.name
  user_name = snowflake_service_user.deploy.name
}
