# memo

切り替え 本番
terraform init -reconfigure -backend-config=pd.s3.tfbackend

apply　本番
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