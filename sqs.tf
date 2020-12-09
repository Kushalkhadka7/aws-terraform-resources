resource "aws_sqs_queue" "default_queue" {
  name                        = "default_queue.fifo"
  max_message_size            = 2048
  visibility_timeout_seconds  = 15
  message_retention_seconds   = 345600
  fifo_queue                  = true
  content_based_deduplication = true
  receive_wait_time_seconds   = 20 #long polling


  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue.arn
    maxReceiveCount     = 4
  })
}

resource "aws_sqs_queue" "dead_letter_queue" {
  name                      = "dead_letter_queue"
  message_retention_seconds = 345600
}

resource "aws_sqs_queue_policy" "test" {
  queue_url = aws_sqs_queue.default_queue.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.q.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.example.arn}"
        }
      }
    }
  ]
}
POLICY
}
