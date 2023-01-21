module "app_sg" {
  source = "./module/security_group"

  sg_name     = "app_sg"
  description = "app_sg"
  vpc_id      = var.vpc_id

  project = var.project
  env     = var.env
  sgname  = "app-sg"
}