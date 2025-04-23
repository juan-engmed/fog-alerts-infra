# Nome da função Lambda
variable "function_name" {
  type        = string
  description = "Nome da função Lambda"
}

# Caminho do .zip com o código
variable "zip_path" {
  type        = string
  description = "Caminho do arquivo ZIP da função"
}

# Permissões específicas da função
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
