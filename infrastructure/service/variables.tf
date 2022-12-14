variable "region" {
  description = "リージョン"
}

variable "project" {
  description = "リソース名のProject"
  default     = "trial"
}

variable "service" {
  description = "サービス名"
  default     = "circleci"
}

variable "environment" {
  description = "環境"
  default     = "dev"
}

locals {
  commons = {
    region      = var.region
    project     = var.project
    service     = var.service
    environment = var.environment
    workspace   = terraform.workspace
    account_id  = data.aws_caller_identity._.account_id
  }
}
