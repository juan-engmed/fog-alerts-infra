# =============================
# CONFIGURAÇÃO DO TERRAFORM
# =============================

terraform {
  # Indicamos que vamos usar o provedor da AWS
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Garante que usamos uma versão estável e moderna
    }
  }

  # BACKEND REMOTO (opcional no início, mas vamos preparar)
  # O backend guarda o estado da infraestrutura
  # Usamos S3 como armazenamento remoto
  backend "s3" {
    bucket         = "fog-alerts-terraform-states"    # Nome do bucket S3 onde o estado será salvo
    key            = "dev/infra.tfstate"       # Caminho dentro do bucket para o arquivo
    region         = "us-east-1"               # Região onde o bucket está localizado
    encrypt        = true                      # Criptografa o arquivo de estado no S3
    # dynamodb_table = "fog-terraform-locks"   # Linha comentada (a gente ativa mais tarde se quiser lock)
  }
}

# =============================
# PROVIDER AWS
# =============================

provider "aws" {
  region = "us-east-1"  # Região padrão (compatível com Free Tier e ampla cobertura de serviços)
}
