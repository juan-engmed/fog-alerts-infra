# Nome real do tópico na AWS (ex: "fog-alerts-topic")
variable "topic_name" {
  description = "Nome do tópico SNS"
  type        = string
}

# Nome do ambiente: dev, hmg, prod...
variable "environment" {
  description = "Ambiente de destino (dev, hmg, prod)"
  type        = string
}

# Nome de quem é responsável por esse recurso
variable "owner" {
  description = "Responsável pelo recurso"
  type        = string
}

# Variáveis de ambiente da função
variable "environment_variables" {
  description = "Variáveis de ambiente para a função Lambda"
  type        = map(string)
  default     = {}
}