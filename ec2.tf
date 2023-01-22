data "aws_ami" "my_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.*-x86_64-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


module "ec2_instance" {
  source = "./module/ec2_instance"

  my_ami          = data.aws_ami.my_ami.id
  subnet_id       = module.pub_subnet_A.subnet_id
  security_groups = [module.app_sg.sg_id]
  key_name        = aws_key_pair.this.key_name
  project         = var.project
  env             = var.env
  ec2_name        = "app_server"
}