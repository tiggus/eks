# resource "aws_secretsmanager_secret" "aurora" {
#   description                    = null
#   force_overwrite_replica_secret = null
#   kms_key_id                     = null
#   name                           = "rds-secret-${random_id.random.hex}"
#   name_prefix                    = null
#   policy                         = null
#   recovery_window_in_days        = null
#   tags                           = {}
#   tags_all                       = {}
# }