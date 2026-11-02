module "app_environment" {
  source = "../../modules/snowflake_app_env"

  app_name               = var.app_name
  environment            = var.environment
  credit_quota           = var.credit_quota
  deploy_user_public_key = var.deploy_user_public_key
}
