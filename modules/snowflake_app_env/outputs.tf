output "database_name" {
  description = "Application database name."
  value       = snowflake_database.this.name
}

output "warehouse_name" {
  description = "Application warehouse name."
  value       = snowflake_warehouse.this.name
}

output "owner_role_name" {
  description = "Application owner role name."
  value       = snowflake_account_role.owner.name
}

output "rw_role_name" {
  description = "Application read-write role name."
  value       = snowflake_account_role.rw.name
}

output "ro_role_name" {
  description = "Application read-only role name."
  value       = snowflake_account_role.ro.name
}

output "deploy_user_name" {
  description = "Application deploy service-user name."
  value       = snowflake_service_user.deploy.name
}

output "resource_monitor_name" {
  description = "Application resource monitor name."
  value       = snowflake_resource_monitor.this.name
}
