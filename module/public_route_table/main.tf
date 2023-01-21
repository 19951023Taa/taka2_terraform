resource "aws_route_table" "public_this" {
  vpc_id = var.vpc_id

    tags = {
    "Name" = "${var.project}-${var.env}-${var.route_table_name}"
  }
}

resource "aws_route" "public_this" {
  route_table_id            = aws_route_table.public_this.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = var.gateway_id
}

resource "aws_route_table_association" "public_A_this" {
  subnet_id = var.subnet_id_A
  route_table_id = aws_route_table.public_this.id
}

resource "aws_route_table_association" "public_C_this" {
  subnet_id = var.subnet_id_C
  route_table_id = aws_route_table.public_this.id
}

