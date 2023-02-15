resource "aws_elasticache_subnet_group" "this" {
  name = "${var.project}-${var.env}-subnetgroup"
  subnet_ids = [
    module.pulivate_subnet_A.subnet_id,
    module.pulivate_subnet_C.subnet_id
  ]
}

resource "aws_elasticache_replication_group" "this" {
  automatic_failover_enabled    = true #masterに障害が起こった場合にリードレプリカを昇格するか
  multi_az_enabled              = true
  replication_group_description = "test" #説明
  number_cache_clusters         = 2 # master + replica
  subnet_group_name             = aws_elasticache_subnet_group.this.name
  replication_group_id          = "${var.project}-${var.env}-redis"
  node_type                     = "cache.t2.small"
  parameter_group_name          = "default.redis7"
  port                          = 6379
}

