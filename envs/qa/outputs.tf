output "database_name" {
  value = module.app_environment.database_name
}

output "warehouse_name" {
  value = module.app_environment.warehouse_name
}

output "owner_role_name" {
  value = module.app_environment.owner_role_name
}

output "deploy_user_name" {
  value = module.app_environment.deploy_user_name
}
