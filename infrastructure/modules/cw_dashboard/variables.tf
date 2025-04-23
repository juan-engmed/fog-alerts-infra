variable "dashboard_name" {
  type        = string
  description = "Nome do dashboard CloudWatch"
  default     = "FogAlertsDashboard"
}

variable "sns_topic_name" {
  type        = string
  description = "Nome do tópico SNS"
}

variable "sqs_queue_name" {
  type        = string
  description = "Nome da fila SQS"
}

variable "lambda_logger_name" {
  type        = string
  description = "Nome da função Lambda que salva no S3"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
}
