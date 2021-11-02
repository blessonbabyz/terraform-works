provider "aws" {
   region = "eu-central-1"
}
resource "aws_instance" "blesson_terraform_instance" {
  ami           = "ami-05f7491af5eef733a"
  instance_type = "t2.micro"

  tags = {
    Name = "blesson terraform server"
    Owner ="blesson baby"
  }
}
