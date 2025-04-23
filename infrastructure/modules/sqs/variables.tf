# Nome real da fila (ex: fog-alerts-log-queue)
variable "queue_name" {
  description = "Nome da fila SQS"
  type        = string
}

# ARN do tópico SNS que vai enviar mensagens para a fila
variable "sns_topic_arn" {
  description = "ARN do tópico SNS para fanout"
  type        = string
}

# Ambiente de destino (dev, prod, etc)
variable "environment" {
  description = "Ambiente de implantação"
  type        = string
}

# Nome do responsável pelo recurso
variable "owner" {
  description = "Responsável pela infraestrutura"
  type        = string
}
