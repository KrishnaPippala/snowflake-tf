variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "credit_quota" {
  type = number
}

variable "deploy_user_public_key" {
  type      = string
  sensitive = true
}

variable "snowflake_organization_name" {
  type      = string
  sensitive = true
}

variable "snowflake_account_name" {
  type      = string
  sensitive = true
}

variable "snowflake_user" {
  type      = string
  sensitive = true
}

variable "snowflake_private_key" {
  type      = string
  sensitive = true
}

variable "snowflake_private_key_passphrase" {
  type      = string
  default   = null
  nullable  = true
  sensitive = true
}

# Resource monitors can only be created by ACCOUNTADMIN.
variable "snowflake_role" {
  type    = string
  default = "ACCOUNTADMIN"
}
