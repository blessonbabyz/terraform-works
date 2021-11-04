provider "aws" {
 region = "eu-central-1"
}
resource "aws_db_instance" "prod" {
 identifier = "prod-mysql-rds"
 allocated_storage =20
 storage_type = "gp2"
 engine = "mysql"
 engine_version ="5.7"
 instance_class = "db.t2.micro"
 parameter_group_name = "default.mysql5.7"
 skip_final_snapshot = true
 apply_immediately =true
 username = "admin"
 password = data.aws_ssm_parameter.rds_password.value
}

#generating password
resource "random_password" "main" {
 length = 20 
 special = true           #by default !@#$%^&*()_+[]{}<>:?
 override_special = "#!()_"
}

# Store password
resource "aws_ssm_parameter" "rds_password" {
 name = "/prod/prod-mysql-rds/password"
 description = "Master password for RDS Database"
 type = "SecureString"
 value = random_password.main.result
}

#retrive password
 data "aws_ssm_parameter" "rds_password" {
 name = "/prod/prod-mysql-rds/password"
 depends_on = [aws_ssm_parameter.rds_password]
}

output "rds_address" {
 value = aws_db_instance.prod.address
}

output "rds_port" {
 value = aws_db_instance.prod.port
}

output "rds_username" {
 value = aws_db_instance.prod.username
}

output "rds_password" {
 value = data.aws_ssm_parameter.rds_password.value
 sensitive = true  
}
