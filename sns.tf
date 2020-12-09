resource "aws_sns_topic" "default_sns_topic" {
  name         = "default_sns_topic"
  display_name = "default_sns_topic"

  delivery_policy = <<EOF
    {
      "http": {
        "defaultHealthyRetryPolicy": {
          "minDelayTarget": 20,
          "maxDelayTarget": 20,
          "numRetries": 3,
          "numMaxDelayRetries": 0,
          "numNoDelayRetries": 0,
          "numMinDelayRetries": 0,
          "backoffFunction": "linear"
        },
        "disableSubscriptionOverrides": false,
        "defaultThrottlePolicy": {
          "maxReceivesPerSecond": 1
        }
      }
    }
    EOF
}


resource "aws_sns_topic_subscription" "sns-topic" {
  provider  = "aws.sns2sqs"
  topic_arn = aws_sns_topic.default_sns_topic.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.default_queue.arn
}
