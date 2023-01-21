resource "aws_route_table" "private_this" {
  vpc_id = var.vpc_id

    tags = {
    "Name" = "${var.project}-${var.env}-${var.route_table_name}"
  }
}

# resource "aws_route" "private_this" {
#   route_table_id            = aws_route_table.private_this.id
# }

resource "aws_route_table_association" "private_A_this" {
  subnet_id = var.subnet_id_A
  route_table_id = aws_route_table.private_this.id
}

resource "aws_route_table_association" "private_C_this" {
  subnet_id = var.subnet_id_C
  route_table_id = aws_route_table.private_this.id
}

