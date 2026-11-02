# Creating a resource monitor and assigning it to a warehouse requires ACCOUNTADMIN.
resource "snowflake_resource_monitor" "this" {
  name            = "${local.name_prefix}_RM"
  credit_quota    = var.credit_quota
  notify_triggers = [75]
  suspend_trigger = 100
}
