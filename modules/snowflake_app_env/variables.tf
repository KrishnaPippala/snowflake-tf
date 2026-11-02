variable "app_name" {
  description = "Application identifier. It is normalized to uppercase for Snowflake object names."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z][A-Za-z0-9_]*$", var.app_name))
    error_message = "app_name must start with a letter and contain only letters, numbers, and underscores."
  }
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "qa", "stage"], lower(var.environment))
    error_message = "environment must be one of: dev, qa, stage."
  }
}

variable "credit_quota" {
  description = "Credit quota for the environment resource monitor."
  type        = number
}

variable "deploy_user_public_key" {
  description = "RSA public key for the deploy service user. PEM headers and line breaks are stripped automatically."
  type        = string
  sensitive   = true
}
