variable "dashboard_name" {
  description = "Nome do dashboard CloudWatch"
  type        = string
}

variable "aws_region" {
  description = "Região AWS"
  type        = string
}

variable "sns_topic_name" {
  description = "Nome do tópico SNS"
  type        = string
}

variable "sqs_queue_name" {
  description = "Nome da fila SQS"
  type        = string
}

variable "lambda_logger_name" {
  description = "Nome da função Lambda de logs"
  type        = string
}
