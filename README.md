# memo

切り替え 本番
terraform init -reconfigure -backend-config=pd.s3.tfbackend

apply　本番
terraform plan -var-file=_pd.tfvars -state=pd.s3.tfbackend
terraform apply -var-file=_pd.tfvars -state=pd.s3.tfbackend

変数　tfファイルで変数を指定して、tfvarsで値を設定
~.tfvarsで設定できる変数形式
message = "Hello World！"

.tfで設定できる変数形式
variable "message" {
  type   = string
  default = "nothing"
}

locals {
   name = "my-name"
   env = "test"
}


module output
====================
outputする側
output "subnet_id" {
  value = aws_subnet.main.id
}

output値を使う側
module/main.tf
subnet_id = var.subnet_id

module/variable.tf
variable "subnet_id" {}

module呼び出し時
subnet_id = module.test_subnetA.subnet_id
            モジュール名、output名