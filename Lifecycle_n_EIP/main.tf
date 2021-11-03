provider "aws"{
  region = "eu-central-1"
}

resource "aws_eip" "web" {
 instance = aws_instance.web.id
 tags = {
    Name = "EIP for webserver built by terraform"
    Owner= "Blesson Baby"
 }
}
resource "aws_instance" "web"{
 ami = "ami-05f7491af5eef733a"  #ubuntu image
 instance_type = "t2.micro"
 vpc_security_group_ids = [aws_security_group.web.id]  #this line written after creating the aws security resources
 user_data = file("blesson.sh")    #reference to external file called blesson.sh
  tags ={
  Name = "Webserver built using terraform"
  Owner ="Blesson Baby"
 }
 lifecycle {
   create_before_destroy =true
 }
}
resource "aws_security_group" "web" {
 name ="webserver-sg"
 description ="Security group for my webserver"

 dynamic "ingress"{
   for_each =["80","443"]
   content {
   from_port = ingress.value
   to_port = ingress.value
   protocol = "tcp"
   cidr_blocks =["0.0.0.0/0"]
   }
  }

 egress{
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks =["0.0.0.0/0"]
  }
 tags = {
   Name = "Webserver SG by Terraform"
   Owner = "Blesson Baby"
  }
}
 
