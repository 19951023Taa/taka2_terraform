resource "aws_instance" "this" {
  ami = var.my_ami
  instance_type = "t3.micro"
  subnet_id = var.subnet_id
  associate_public_ip_address = "true"


    tags = {
    "Name" = "${var.project}-${var.env}-${var.ec2_name}"
  }
}