locals {
  roles = {
    owner = snowflake_account_role.owner.name
    rw    = snowflake_account_role.rw.name
    ro    = snowflake_account_role.ro.name
  }

  owner_create_privileges = [
    "CREATE TABLE",
    "CREATE VIEW",
    "CREATE STAGE",
    "CREATE FILE FORMAT",
    "CREATE SEQUENCE",
    "CREATE FUNCTION",
    "CREATE PROCEDURE",
    "CREATE STREAM",
    "CREATE TASK",
  ]
}

resource "snowflake_grant_privileges_to_account_role" "database_usage" {
  for_each = local.roles

  account_role_name = each.value
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.this.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "warehouse_usage" {
  for_each = local.roles

  account_role_name = each.value
  privileges        = ["USAGE"]

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.this.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "schema_usage" {
  for_each = local.roles

  account_role_name = each.value
  privileges        = ["USAGE"]

  on_schema {
    all_schemas_in_database = snowflake_database.this.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "owner_create_schema" {
  account_role_name = snowflake_account_role.owner.name
  privileges        = ["CREATE SCHEMA"]

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.this.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "owner_create_objects" {
  account_role_name = snowflake_account_role.owner.name
  privileges        = local.owner_create_privileges

  on_schema {
    all_schemas_in_database = snowflake_database.this.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "future_schema_usage" {
  for_each = local.roles

  account_role_name = each.value
  privileges        = ["USAGE"]

  on_schema {
    future_schemas_in_database = snowflake_database.this.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "owner_future_schema_create" {
  account_role_name = snowflake_account_role.owner.name
  privileges        = local.owner_create_privileges

  on_schema {
    future_schemas_in_database = snowflake_database.this.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "rw_future_tables" {
  account_role_name = snowflake_account_role.rw.name
  privileges        = ["SELECT", "INSERT", "UPDATE", "DELETE"]

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.this.name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "ro_future_tables" {
  account_role_name = snowflake_account_role.ro.name
  privileges        = ["SELECT"]

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_database        = snowflake_database.this.name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "rw_future_views" {
  account_role_name = snowflake_account_role.rw.name
  privileges        = ["SELECT"]

  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_database        = snowflake_database.this.name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "ro_future_views" {
  account_role_name = snowflake_account_role.ro.name
  privileges        = ["SELECT"]

  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_database        = snowflake_database.this.name
    }
  }
}
