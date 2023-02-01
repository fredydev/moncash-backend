# resource "aws_secretsmanager_secret" "moncash_secrets" {
#   name = "${local.name}"
#   kms_key_id = null
#   description = "Moncash secrets"
#   recovery_window_in_days = var.secret_recovery_window_in_days
#   tags = local.tags
# }