resource "aws_elasticache_subnet_group" "this" {
  name = "${var.project}-${var.env}-subnetgroup"
  subnet_ids = [
    module.pulivate_subnet_A.subnet_id,
    module.pulivate_subnet_C.subnet_id
  ]
}

resource "aws_elasticache_parameter_group" "this" {
  name   = "cache-params"
  family = "redis7"
}

# cluster-enabledを設定すればクラスターモードで起動できる
resource "aws_elasticache_parameter_group" "this_cluster" {
  name   = "cache-params-cluster"
  family = "redis7"

  parameter {
   name  = "cluster-enabled"
   value = "yes"
  } 
}

#　シングル構成
resource "aws_elasticache_replication_group" "this" {
  replication_group_id          = "${var.project}-${var.env}-redis"
  replication_group_description = "test-single" #説明
  engine                        = "redis"
  automatic_failover_enabled    = false         #masterに障害が起こった場合にリードレプリカを昇格するか
  multi_az_enabled              = false
  number_cache_clusters         = 1 # master 
  subnet_group_name             = aws_elasticache_subnet_group.this.name
  node_type                     = "cache.t2.small"
  parameter_group_name          = aws_elasticache_parameter_group.this.name
  port                          = 6379
}

#  クラスター構成
resource "aws_elasticache_replication_group" "this_cluster" {
  replication_group_id          = "${var.project}-${var.env}-redis-cluster"
  replication_group_description = "test-cluster" #説明
  engine                        = "redis"
  automatic_failover_enabled    = true           #masterに障害が起こった場合にリードレプリカを昇格するか
  multi_az_enabled              = true
  subnet_group_name             = aws_elasticache_subnet_group.this.name
  node_type                     = "cache.t2.small"
  parameter_group_name          = "default.redis7.cluster.on" #defaultのパラメータでも一応クラスター起動できる
  port                          = 6379

  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 2
  }
}
