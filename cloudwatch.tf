resource "aws_cloudwatch_metric_alarm" "ec2_cpu_metric" {
  alarm_name = "ec2_cpu_alarm"
  alarm_description = "EC2_CPU_40_metric"
  comparison_operator = "GreaterThanOrEqualToThreshold" # 以上の意味
  evaluation_periods = "1" # データが指定されたしきい値と比較される期間の数。
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "60" # 期間
  statistic = "Average"
  threshold = "40" # しきい値を定義 CPU使用率80%を監視
  insufficient_data_actions = []
  datapoints_to_alarm = "1" # アラームを実行するデータポイント
  dimensions = {
        InstanceId = module.ec2_instance.ec2_id
      }
  alarm_actions = [aws_sns_topic.this.arn]
}