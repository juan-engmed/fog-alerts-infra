# Exporta o ARN da fila para uso posterior (ex: Lambda)
output "sqs_queue_arn" {
  value = aws_sqs_queue.this.arn
}