# Este recurso cria um tópico SNS usando as variáveis recebidas
resource "aws_sns_topic" "this" {
  name = var.topic_name

  # Adicionamos tags para facilitar rastreamento no console e relatórios de custo
  tags = {
    Environment = var.environment
    Project     = "fog-alerts"
    Owner       = var.owner
  }
}