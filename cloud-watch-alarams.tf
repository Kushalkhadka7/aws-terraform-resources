resource "aws_cloudwatch_metric_alarm" "scale_up" {
  alarm_name          = "scale_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 memory for high utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.admin_asg_policy_scale_up.arn}"
  ]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.agents.name}"
  }
}


resource "aws_cloudwatch_metric_alarm" "scale_down" {
  alarm_name          = "scale_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "MemoryUtilization"
  namespace           = "System/Linux"
  period              = "300"
  statistic           = "Average"
  threshold           = "40"
  alarm_description   = "This metric monitors ec2 memory for low utilization on agent hosts"
  alarm_actions = [
    "${aws_autoscaling_policy.admin_asg_policy_scale_down.arn}"
  ]
  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.agents.name}"
  }
}
