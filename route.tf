module "pubic_route" {
  source = "./module/public_route_table"

  vpc_id           = var.vpc_id
  project          = var.project
  env              = var.env
  route_table_name = "public_route_table"
  subnet_id_A      = module.pub_subnet_A.subnet_id
  subnet_id_C      = module.pub_subnet_C.subnet_id
  gateway_id       = aws_internet_gateway.igw.id
}
