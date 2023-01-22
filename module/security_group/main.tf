resource "aws_security_group" "this" {
  name        = var.sg_name
  description = var.description
  vpc_id      = var.vpc_id

  tags = {
   "Name" = "${var.project}-${var.env}-${var.sgname}"
  }
}

resource "aws_security_group_rule" "in_this" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["59.138.66.7/32"]
  security_group_id = aws_security_group.this.id
  
}


resource "aws_security_group_rule" "out_this" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}