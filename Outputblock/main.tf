provider "aws" {
 region = "eu-central-1"
}

resource "aws_instance""my_web_server"{
 ami ="ami-05f7491af5eef733a"  #ubuntu image
 instance_type="t2.micro"
 vpc_security_group_ids = [aws_security_group.general.id]
 tags ={
  Name ="Webserver"
 }
}

resource "aws_instance""app_server"{
 ami ="ami-05f7491af5eef733a"  #ubuntu image
 instance_type="t2.micro"
 vpc_security_group_ids = [aws_security_group.general.id]
 tags ={
  Name ="appserver"
 }
}

resource "aws_instance""db_server"{
 ami ="ami-05f7491af5eef733a"  #ubuntu image
 instance_type="t2.micro"
 vpc_security_group_ids = [aws_security_group.general.id]
 tags ={
  Name ="dbserver"
 }
}

resource "aws_security_group" "general" {
 name= "webserver-sg-terraform"
 description ="Security group for my terrform"


dynamic "ingress" {
  for_each =["80","443"]
  content {
  from_port = ingress.value
  to_port = ingress.value
  protocol = "tcp"
  cidr_blocks =["0.0.0.0/0"]
  }
}

egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks =["0.0.0.0/0"]
  }
 tags={
  Name ="Webserver SG by terraform"
  Owner = "Blesson Baby"
 }
}
output "mysecurity_group_id"{
value = aws_security_group.general.id
}

output "web_private_ip"{
 value = aws_instance.my_web_server.private_ip
}

output "app_public_ip"{
 value = aws_instance.app_server.public_ip
}

output "instances_id"{
 value = [aws_instance.my_web_server.id, aws_instance.db_server.id, aws_instance.app_server.id]
}
