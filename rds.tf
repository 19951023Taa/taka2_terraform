# #---------------------------------------------
# # RDS parameter group
# #---------------------------------------------
# resource "aws_db_parameter_group" "mysql_standalone_parametergroup" {
#   name   = "mysql-standalone-parametergroup"
#   family = "mysql8.0"

#   parameter {
#     name  = "character_set_database"
#     value = "utf8mb4"
#   }

#   parameter {
#     name  = "character_set_server"
#     value = "utf8mb4"
#   }
# }

# #---------------------------------------------
# # RDS option group
# #---------------------------------------------
# resource "aws_db_option_group" "mysql_standalone_optiongroup" {
#   name                 = "mysql-standalone-optiongroup"
#   engine_name          = "mysql"
#   major_engine_version = "8.0"
# }

# #---------------------------------------------
# # RDS subnet group
# #---------------------------------------------
# resource "aws_db_subnet_group" "mysql_standalone_subnetgroup" {
#   name = "mysql-standalone-subnetgroup"
#   subnet_ids = [
#     module.pulivate_subnet_A.subnet_id,
#     module.pulivate_subnet_C.subnet_id
#   ]

#   tags = {
#     Name    = "mysql-standalone-subnetgroup"
#   }
# }

# #---------------------------------------------
# # RDS instance
# #---------------------------------------------
# resource "aws_db_instance" "mysql_standalone" {
#   engine         = "mysql"
#   engine_version = "8.0.23"

#   identifier = "mysql-standalone"

#   username = "admin"
#   password = "password"

#   instance_class = "db.t2.micro"

#   allocated_storage     = 20
#   max_allocated_storage = 50
#   storage_type          = "gp3"
#   storage_encrypted     = false

#   multi_az               = false
#   availability_zone      = "ap-northeast-1a"
#   db_subnet_group_name   = aws_db_subnet_group.mysql_standalone_subnetgroup.name
#   vpc_security_group_ids = [module.app_sg.sg_id]
#   publicly_accessible    = false
#   port                   = 3306

#   name                 = "tastylog"
#   parameter_group_name = aws_db_parameter_group.mysql_standalone_parametergroup.name
#   option_group_name    = aws_db_option_group.mysql_standalone_optiongroup.name

#   backup_window              = "04:00-05:00"
#   backup_retention_period    = 7
#   maintenance_window         = "Mon:05:00-Mon:08:00"
#   auto_minor_version_upgrade = false

#   deletion_protection = false
#   skip_final_snapshot = true

#   apply_immediately = true

#   tags = {
#     Name    = "mysql-standalone"
#   }
# }