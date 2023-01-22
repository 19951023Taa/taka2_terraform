resource "aws_instance" "this" {
  ami = var.my_ami
  instance_type = "t3.micro"
  subnet_id = var.subnet_id
  key_name = var.key_name
  associate_public_ip_address = "true"
  vpc_security_group_ids  = var.security_groups


    tags = {
    "Name" = "${var.project}-${var.env}-${var.ec2_name}"
  }
}