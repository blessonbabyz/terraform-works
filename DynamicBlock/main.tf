provider "aws"{
  region = "eu-central-1"
}


resource "aws_security_group" "web" {
 name ="webserver-sg"
 description ="Security group for my webserver"

 dynamic "ingress"{
   for_each = ["80", "8080", "443", "1000"]
   content {
   description ="Allow port HTTP"
   from_port = ingress.value
   to_port = ingress.value
   protocol = "tcp"      #similar new dynamic block can be made if protocol or cidr block is different
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
 
