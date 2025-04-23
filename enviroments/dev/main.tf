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


# Chamamos o módulo SNS e passamos os valores que ele precisa
module "sns_topic" {
  source      = "../../infrastructure/modules/sns"        # Caminho relativo ao módulo
  topic_name  = "fog-alerts-topic"         # Nome que o recurso vai ter na AWS
  environment = "dev"                      # Ambiente atual
  owner       = "CafezinCloud"                  # Tag de identificação
}

module "sqs_log_queue" {
  source        = "../../infrastructure/modules/sqs"
  queue_name    = "fog-alerts-log-queue"
  sns_topic_arn = module.sns_topic.topic_arn  # Agora acessamos o output exportado
  environment   = "dev"
  owner         = "CafezinCloud"
}

# --- Lambda LOGGER (salva no S3) ---
module "lambda_logger" {
  source         = "../../infrastructure/modules/lambda_logger"
  function_name  = "fog-alerts-logger"
  zip_path       = "${path.module}/../../infrastructure/modules/lambda_logger/lambda.zip"

  role_policy_json = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:PutObject"],
        Resource = "arn:aws:s3:::fog-alerts-log-bucket/*"
      },
      {
        Effect   = "Allow",
        Action   = ["sqs:ReceiveMessage", "sqs:DeleteMessage", "sqs:GetQueueAttributes"],
        Resource = module.sqs_log_queue.sqs_queue_arn
      },
      {
        Effect   = "Allow",
        Action   = ["logs:*"],
        Resource = "*"
      }
    ]
  })

  environment_variables = {
    S3_BUCKET_NAME = "fog-alerts-log-bucket"
  }
}


# --- Lambda TELEGRAM (envia alerta para Telegram) ---
module "lambda_telegram" {
  source         = "../../infrastructure/modules/lambda_telegram"
  function_name  = "fog-alerts-telegram"
  zip_path       = "${path.module}/../../infrastructure/modules/lambda_telegram/lambda.zip"

  role_policy_json = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["logs:*", "secretsmanager:GetSecretValue"],
        Resource = "*"
      }
    ]
  })


  environment_variables = {
    TELEGRAM_SECRET_NAME = "fog-alerts-config"
  }
}

# --- Lambda GOOGLE CHAT (envia alerta para Google Chat) ---
module "lambda_googlechat" {
  source         = "../../infrastructure/modules/lambda_googlechat"
  function_name  = "fog-alerts-googlechat"
  zip_path       = "${path.module}/../../infrastructure/modules/lambda_googlechat/lambda.zip"

  role_policy_json = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["logs:*", "secretsmanager:GetSecretValue"],
        Resource = "*"
      }
    ]
  })

  environment_variables = {
    GOOGLECHAT_SECRET_NAME = "fog-alerts-config"
  }
}
