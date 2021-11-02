provider "aws"{
  region = "eu-central-1"
}

resource "aws_instance" "web"{
 ami = "ami-05f7491af5eef733a"  #ubuntu image
 instance_type = "t2.micro"
 vpc_security_group_ids = [aws_security_group.web.id]  #this line written after creating the aws security resources
 user_data = <<EOF
#!/bin/bash
apt-get update
apt-get install apache2 -y
apt-get install curl -y
MYIP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
echo "<h2>webserver with private ip is $MYIP </h2><br>Built using terraform <br>-blesson baby" > /var/www/html/index.html
service appache2 start
chkconfig appache2 on
EOF
  tags ={
  Name = "Webserver built using terraform"
  Owner ="Blesson Baby"
 }
}
resource "aws_security_group" "web" {
 name ="webserver-sg"
 description ="Security group for my webserver"

 ingress{
   from_port = 80
   to_port = 80
   protocol = "tcp"
   cidr_blocks =["0.0.0.0/0"]
  }

 ingress{
   from_port = 443
   to_port = 443
   protocol = "tcp"
   cidr_blocks =["0.0.0.0/0"]
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
 
