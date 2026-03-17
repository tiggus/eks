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

resource "aws_db_instance" "aurora" {
  allocated_storage = 10
  identifier        = "aurora-db"
  #db_name              = "mydb"
  engine               = "postgres"
  engine_version       = "16.8"
  instance_class       = "db.t4g.micro"
  username             = "dbtiggus"
  password             = "abcd3939"
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true
  apply_immediately = true
}