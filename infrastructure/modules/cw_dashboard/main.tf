resource "aws_cloudwatch_dashboard" "alerts_dashboard" {
  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric",
        x = 0, y = 0, width = 6, height = 6,
        properties = {
          title = "SNS: Publicações",
          metrics = [["AWS/SNS", "NumberOfMessagesPublished", "TopicName", var.sns_topic_name]],
          period = 60,
          stat = "Sum",
          region = var.aws_region
        }
      },
      {
        type = "metric",
        x = 6, y = 0, width = 6, height = 6,
        properties = {
          title = "SQS: Mensagens Visíveis",
          metrics = [["AWS/SQS", "ApproximateNumberOfMessagesVisible", "QueueName", var.sqs_queue_name]],
          period = 60,
          stat = "Average",
          region = var.aws_region
        }
      },
      {
        type = "metric",
        x = 0, y = 6, width = 6, height = 6,
        properties = {
          title = "Lambda: Invocações",
          metrics = [["AWS/Lambda", "Invocations", "FunctionName", var.lambda_logger_name]],
          period = 60,
          stat = "Sum",
          region = var.aws_region
        }
      },
      {
        type = "metric",
        x = 6, y = 6, width = 6, height = 6,
        properties = {
          title = "Lambda: Tempo de Execução",
          metrics = [["AWS/Lambda", "Duration", "FunctionName", var.lambda_logger_name]],
          period = 60,
          stat = "Average",
          region = var.aws_region
        }
      },
      {
        type = "metric",
        x = 0, y = 12, width = 6, height = 6,
        properties = {
          title = "Lambda: Erros",
          metrics = [["AWS/Lambda", "Errors", "FunctionName", var.lambda_logger_name]],
          period = 60,
          stat = "Sum",
          region = var.aws_region
        }
      }
    ]
  })
}
