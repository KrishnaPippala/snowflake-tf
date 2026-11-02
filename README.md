# snowflake-tf

One Snowflake trial account. `envs/dev`, `envs/qa`, and `envs/stage` each have their own state and create that environment's database, schemas (`RAW`, `STAGE`, `CURATED`, `APP`), warehouse, resource monitor, roles, grants, and deploy user.

## Run

From Harness, run Terraform with the working directory set to one environment. Use a different state key for each directory.

```bash
cd envs/dev
terraform init
terraform plan
terraform apply
```

Repeat in `envs/qa` and `envs/stage`.

Copy `terraform.tfvars.example` to `terraform.tfvars` for the non-secret values (`app_name`, `environment`, `credit_quota`). Pass the rest as Harness secrets:

```text
TF_VAR_snowflake_organization_name
TF_VAR_snowflake_account_name
TF_VAR_snowflake_user
TF_VAR_snowflake_private_key
TF_VAR_snowflake_private_key_passphrase
TF_VAR_deploy_user_public_key
```

`TF_VAR_snowflake_user` is `TF_SVC`. Auth is key-pair JWT. The passphrase is optional. Do not commit tfvars or private keys.

## Before the first apply

The provider uses `ACCOUNTADMIN` because Snowflake only lets that role create a resource monitor and attach it to a warehouse. Grant it to the Terraform user once:

```sql
GRANT ROLE ACCOUNTADMIN TO USER TF_SVC;
```

The monitor notifies at 75% and suspends the warehouse at 100%. Account admins receive the notification after they turn on resource-monitor notifications in Snowflake.