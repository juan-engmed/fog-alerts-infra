variable "function_name" {
  type        = string
  description = "Nome da função Lambda"
}

variable "zip_path" {
  type        = string
  description = "Caminho do .zip com o código da Lambda"
}

variable "role_policy_json" {
  type        = string
  description = "Permissões da função Lambda em formato JSON"
}

# Variáveis de ambiente da função
variable "environment_variables" {
  description = "Variáveis de ambiente para a função Lambda"
  type        = map(string)
  default     = {}
}
