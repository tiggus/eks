# resource "aws_rds_cluster" "postgresql" {
#   cluster_identifier      = "aurora-cluster"
#   engine                  = "aurora-postgresql"
#   availability_zones      = ["us-east-1"]
#   database_name           = "aurora-database"
#   master_username         = "00000001"
#   master_password         = "must_be_eight_characters"
#   backup_retention_period = 0
#   preferred_backup_window = "07:00-09:00"
#   WithExpressConfiguration = true
# }
