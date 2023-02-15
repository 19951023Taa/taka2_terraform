resource "aws_key_pair" "this" {
  key_name   = "${var.project}-${var.env}-key"
  public_key = file("./ssh-key/terra-dev-key.pub")

  tags = {
    "Name" = "${var.project}-${var.env}-key"
  }
}