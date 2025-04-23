# Cria uma fila SQS que vai receber alertas do SNS
resource "aws_sqs_queue" "this" {
  name = var.queue_name

  tags = {
    # Usamos tags para rastreabilidade e controle de custos
    Environment = var.environment
    Project     = "fog-alerts"
    Owner       = var.owner
  }
}

# Conecta a fila ao tópico SNS, criando uma assinatura
resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = var.sns_topic_arn     # ARN do tópico SNS que envia mensagens
  protocol  = "sqs"                  # Protocolo de entrega: fila SQS
  endpoint  = aws_sqs_queue.this.arn # ARN da fila como destino

  # Garante que a fila exista antes da assinatura
  depends_on = [aws_sqs_queue.this]
}