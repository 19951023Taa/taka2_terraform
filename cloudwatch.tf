resource "aws_cloudwatch_metric_alarm" "ec2_cpu_metric" {
  alarm_name                = "ec2_cpu_alarm"
  alarm_description         = "EC2_CPU_70_metric"
  comparison_operator       = "GreaterThanOrEqualToThreshold" # 以上の意味
  evaluation_periods        = "3"                             # データが指定されたしきい値と比較される期間の数。
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "180" # 期間
  statistic                 = "Average"
  threshold                 = "70" # しきい値を定義 CPU使用率70%を監視
  insufficient_data_actions = []
  datapoints_to_alarm       = "2" # アラームを実行するデータポイント 何回超えたらアラームするか
  dimensions = {
    InstanceId = module.ec2_instance.ec2_id
  }
  alarm_actions = [aws_sns_topic.this.arn]
}